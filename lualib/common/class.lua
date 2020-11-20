-- ————————————————
-- 版权声明：本文为CSDN博主「my张小秋」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
-- 原文链接：https://blog.csdn.net/mywcyfl/java/article/details/37706247
local _class={}
local setmetatable = setmetatable
return function(base)
    local class_type={}
 
    class_type.__type   = 'class'
    class_type.ctor     = false
    
    local vtbl = {}
    _class[class_type] = vtbl
    setmetatable(class_type,{__newindex = vtbl, __index = vtbl})
 
    if base then
        setmetatable(vtbl,{__index=
            function(t,k)
                local ret=_class[base][k]
                vtbl[k]=ret
                return ret
            end
        })
    end
    
    class_type.__base   = base
    class_type.new      = function(...)
        --create a object, dependent on .__createFunc
        local obj= {}
        obj.__base  = class_type
        obj.__type  = 'object'
        do
            local create
            create = function(c, ...)
                if c.__base then
                    create(c.__base, ...)
                end
                if c.ctor then
                    c.ctor(obj, ...)
                end
            end
 
            create(class_type,...)
        end
 
        setmetatable(obj,{ __index = _class[class_type] })
        return obj
    end
 
    class_type.super = function(self,this, f, ...)
        return this.__base[f](self, ...)
    end
 
    return class_type
end

