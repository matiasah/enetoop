local Library = ...

local NetObject = {}

NetObject.__index = NetObject
NetObject.__type = "NetObject"

function NetObject:new(Object)
	
	local self = setmetatable({}, NetObject)
	
	self.Object = setmetatable({ Object }, {__mode = "v"})
	
	Object.__net = self
	
	return self
	
end

function NetObject:Release()
	
end