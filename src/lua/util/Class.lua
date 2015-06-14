-- Base Class --

local Class = {}

function Class:new(obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

return Class
