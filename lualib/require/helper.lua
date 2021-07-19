local require = require

return function(mode)
    return require(""..mode)
end