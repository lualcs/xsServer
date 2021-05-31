
#include "../lua/lua.h"
#include "../lua/lauxlib.h"
 
struct sBuffer 
{
  int   lenght;
  char  buffer[2^16];
};

enum eType
{
    luaFalse   =        -128,		//索引为false
    luaTrue    =    	  -127,		//索引为true
    luaInt08    =    	  -126,		//int8
    luaInt16    =    	  -125,		//int16
    luaInt24    =    	  -124,		//int24
    luaInt32    =    	  -123,		//int32
    luaInt40    =    	  -122,		//int40
    luaInt48    =    	  -121,		//int48
    luaInt56    =    	  -120,		//int56
    luaInt64    =    	  -119,		//int64		
    luaFloat   =          -118,		//double
    luaText    =          -117,		//字符串类型
    luaLeft	   =          -116,		//{
    luaRigh	   =          -115,		//}
    luaMini	   =          -128,		//开始
    luaMaxi	   =          -115,		//结束
};

static struct sBuffer buffer;

//剩余类型判断-针对0~251
#define IS_NV(v)	(v >= 0 && v <= (255 - (luaMaxi - luaMini + 1)))
#define IS_NT(t)	(t > luaMaxi && t <= 127)
#define AS_NV(t)	(t - luaMaxi - 1)
#define AS_NT(v)	(v + luaMaxi + 1)

#define IfHead()	(0 == buffer.lenght)
#define Lenght()	(buffer.lenght)

#define writeByte(t)				buffer.buffer[buffer.lenght++] = t
#define writeBool(b)				writeByte(b?luaTrue:luaFalse)
#define writeText(s)				memcpy(buffer.buffer+buffer.lenght,s,strlen(s)+1)
#define wirteInt08(v)				writeByte(v)
#define wirteInt16(v)				writeByte(v>>8);writeByte(v)
#define wirteInt24(v)				writeByte(v>>16);wirteInt16(v)
#define wirteInt32(v)				writeByte(v>>24);wirteInt24(v)
#define wirteInt40(v)				writeByte(v>>32);wirteInt32(v)
#define wirteInt48(v)				writeByte(v>>40);wirteInt40(v)
#define wirteInt56(v)				writeByte(v>>48);wirteInt48(v)
#define wirteInt64(v)				writeByte(v>>56);wirteInt56(v)
#define writeDouble(v)				*(double*)&buffer.buffer[buffer.lenght]=v;buffer.lenght+=8

//数字大小
static int numberSize(double number)
{
	int64_t integer = (int64_t)number;
	/*判断是整数*/
	if (number == integer && number >= 0)
	{
		integer = abs(integer);
		for (int i = 0; i < 64; i++){
			if (pow(2, i) >= integer + 1)//正数要注意一下
			{
				return (i / 8) + 1;
			}
		}

	}
	return 8;
}

//数字类型
static int numberType(double number, int isize)
{
	int64_t integer = (int64_t)number;
	if (integer != number)
	{
		return luaFloat;
	}
	else if (number < 0)
	{
		return luaInt64;
	}
	else
	{
		return luaInt08 + isize - 1;
	}
}
 
//设置值
static void writeNumber(double number)
{
	int64_t integer = (int64_t)number;
	//set key value
	int isize = numberSize(number);
	int itype = numberType(number, isize);

	//特殊数值
	if (luaFloat != itype && IS_NV(integer))
	{
		writeByte(AS_NT(integer));
		return;
	}
	
	writeByte(AS_NT(itype));

	switch(itype)
	{
	case luaFloat:writeDouble(number);break;
	case luaInt08:wirteInt08((int64_t)number);break;
	case luaInt16:wirteInt16((int64_t)number);break;
	case luaInt24:wirteInt24((int64_t)number);break;
	case luaInt32:wirteInt32((int64_t)number);break;
	case luaInt40:wirteInt40((int64_t)number);break;
	case luaInt48:wirteInt48((int64_t)number);break;
	case luaInt56:wirteInt56((int64_t)number);break;
	case luaInt64:wirteInt64((int64_t)number);break;
	}
}


//编码
static int luaEncode(lua_State *L) 
{
	int8_t bHead = IfHead();
	//参数初始化
	if (bHead)
	{
		//解码开头
		if (0 != Lenght())
		{
			luaEncode(L);
		}
		else
		{
			//获取堆栈数量
			int n = lua_gettop(L);
			if (1 < n)
			{
				writeNumber(1);
				writeByte(luaLeft);
			}
			//遍历堆栈
			for (int p = 1; p <= n; p++)
			{
				if (1 < n)
				{
					writeNumber(p);
				}

				if (lua_istable(L, p))
				{
					//记录开头表
					if (1 < n)
					{ 
						writeByte(luaLeft); 
					}
					
					luaEncode(L);
					
					//记录表结尾
					if (1 < n)
					{ 
						writeByte(luaRigh); 
					}
				}
				else if (lua_isboolean(L, p))
				{
					writeBool(lua_toboolean(L, p));
				}
				else if (luaIsNumber(L, p))
				{
					writeNumber(lua_tonumber(L, p));
				}
				else if (luaIsString(L, p))
				{
					writeText(lua_tostring(L, p));
				}
				else
				{
					printf("%s 不支持类型 %s ", lua_tostring(L, p), lua_typename(L, p));
				}
			}

			if (1 < n){
				writeByte(luaRigh);
			}
		}

	}
	else
	{
		//必须是table
		if (!lua_istable(L, 0))
		{
			return;
		}

		// 将table拷贝到栈顶
		lua_pushvalue(L, 0);
		//int it = lua_gettop(L);
		// 压入一个nil值，充当起始的key
		lua_pushnil(L);
		while (lua_next(L, -2))
		{
			// 现在的栈：-1 => value; -2 => key; index => table
			// 拷贝一份 key 到栈顶，然后对它做 lua_tostring 就不会改变原始的 key 值了
			lua_pushvalue(L, -2);
			// 现在的栈：-1 => key; -2 => value; -3 => key; index => table

			if (lua_isboolean(L, -1))
			{
				writeBool(lua_toboolean(L, -1));
			}
			else if (luaIsNumber(L, -1))
			{
				writeNumber(lua_tonumber(L, -1));
			}
			else if (luaIsString(L, -1))
			{
				writeText(lua_tostring(L, -1));
			}
			else
			{
				printf("_toBinary key not support %s", lua_typename(L, -1));
			}

			if (lua_istable(L, -2))
			{
				// 此刻-2 => value
				writeByte(luaLeft);
				luaEncode(L);
				writeByte(luaRigh);
			}
			else if (lua_isboolean(L, -2))
			{
				writeBool(lua_toboolean(L, -2));
			}
			else if (luaIsNumber(L, -2))
			{
				writeNumber(lua_tonumber(L, -2));
			}
			else if (luaIsString(L, -2))
			{
				writeText(lua_tostring(L, -2));
			}
			else
			{
				printf("_toBinary value not support %s", lua_typename(L, -1));
			}
			
			// 弹出 value 和拷贝的 key，留下原始的 key 作为下一次 lua_next 的参数
			lua_pop(L, 2);
			// 现在的栈：-1 => key; index => table
		}
		// 现在的栈：index => table （最后 lua_next 返回 0 的时候它已经把上一次留下的 key 给弹出了）
		// 弹出上面被拷贝的table
		lua_pop(L, 1);
	}

	if(bHead)
	{
		buffer.buffer[buffer.lenght] = 0;
		lua_pushlstring(L,buffer.buffer,buffer.lenght+1);
		buffer.lenght = 0;
	}
	return 1;
}

//解码
static int luaDecode(lua_State *L) 
{
	size_t sizet = 0;
	const char* binary = lua_tolstring(L,1,&sizet);

	//压入调用函数
	lua_newtable(L);

	//压入参数
	int itype, ISize;
	double value_number;
	int count = 0;

	//Create a table
	lua_newtable(L);

	int start = 0; 
	while (start < buffer.lenght)
	{
		count += 1;
		itype = buffer.buffer[start++];

		switch (itype)
		{
		case luaLeft:
		{
			//表开头
			count = 0;
			lua_newtable(L);
			break;
		}
		case luaRigh:
		{
			//表结束
			count = 0;
			lua_settable(L, -3);
			break;
		}
		case luaFalse:
		{
			//false
			lua_pushboolean(L, 0);
		}
		case luaTrue:
		{
			//true
			lua_pushboolean(L, 1);
		}
		case luaFloat:
		{
			//float
			lua_pushnumber(L, value_number);
			start+=8;
		}
		case luaText:
		{
			//字符串
			ISize = strlen(buffer.buffer+start) + 1;
			lua_pushstring(L, buffer.buffer);
			start+=ISize;
		}
		case luaInt08:
		case luaInt16:
		case luaInt24:
		case luaInt32:
		case luaInt40:
		case luaInt48:
		case luaInt56:
		case luaInt64:
		{
			ISize = itype - luaInt08 + 1;
			int64_t val = 0;
			memcpy(&val, buffer.buffer+start, ISize);
			lua_pushnumber(L, val);
			start+=ISize;
		}
		default:
		{
			if (IS_NT(itype))
			{
				lua_pushnumber(L, AS_NV(itype));
			}
		}
		}

		/*A pair of key values are saved*/
		if (2 == count)
		{
			lua_settable(L, -3);
			count = 0;
		}
	}
	
	return 1;
}

int luaopen_luabinarry(lua_State *L) {
  luaL_checkversion(L);
 
  luaL_Reg l[] = {
    {"luaEncode", luaEncode},
    {"luaDecode", luaDecode},
    { NULL, NULL },
  };
 
  luaL_newlib(L, l);
  return 1;
}