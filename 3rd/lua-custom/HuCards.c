
#include "../lua/lua.h"
#include "../lua/lauxlib.h"
 
 
int luaopen_HuCards(lua_State *L) {
  luaL_checkversion(L);
 
  luaL_Reg l[] = {
    { NULL, NULL },
  };
 
  luaL_newlib(L, l);
  return 1;
}