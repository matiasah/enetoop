local Path = ...
local RPath = Path:gsub("%.", "/")

local Library = {}

Library.enet = require("lua-enet")

assert( love.filesystem.load( RPath .. "/NetHost.lua") ) ( Library )
assert( love.filesystem.load( RPath .. "/NetClass.lua") ) ( Library )
assert( love.filesystem.load( RPath .. "/NetObject.lua" ) ) ( Library )

assert( love.filesystem.load( RPath .. "/util.lua") ) ( Library )

return Library