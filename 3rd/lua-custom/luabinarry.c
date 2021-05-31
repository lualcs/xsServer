
#include "../lua/lua.h"
#include "../lua/lauxlib.h"
 
//微秒
static int luaEncode(lua_State *L) {
    
}

//微秒
static int luaDecode(lua_State *L) {
    
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