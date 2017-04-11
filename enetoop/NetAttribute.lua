local Library = ...

NetAttribute = {}
NetAttribute.__index = NetAttribute
NetAttribute.__type = "NetAttribute"

NetAttribute.Name = ""
NetAttribute.Type = nil
NetAttribute.Send = true
NetAttribute.Receive = true
NetAttribute.Mode = "reliable"
NetAttribute.Channel = 0

function NetAttribute:new(NetClass, Name, Type, Send, Receive, Mode, Channel)
	
	local self = setmetatable({}, NetAttribute)
	
	self.NetClass = NetClass
	self.Name = Name
	self.Type = Type
	self.Send = Send
	self.Receive = Receive
	self.Mode = Mode
	self.Channel = Channel
	
	return self
	
end

function NetAttribute:HasChanged(NetObject)
	
	local Object = NetObject:GetObject()
	
	if Object then
		
		return Object[self.Name] ~= NetObject:GetValue( self.Name )
		
	end
	
	return false
	
end

function NetAttribute:GetSend()
	
	return self.Send
	
end

function NetAttribute:GetReceive()
	
	return self.Receive
	
end

function NetAttribute:GetMode()
	
	return self.Mode
	
end

function NetAttribute:GetChannel()
	
	return self.Channel
	
end