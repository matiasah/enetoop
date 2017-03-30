local Library = ...

local NetClass = {}

NetClass.__index = NetClass
NetClass.__type = NetClass

function NetClass:new(Class)
	
	if Library.GetRegistry(Class.__type) then
		
		return nil
		
	end
	
	local self = setmetatable({}, NetClass)
	
	self.Attributes = {} 								-- self.Attributes[Name] = {Send = true, Receive = true, Type = some_class.__type}
	
	return self
	
end

function NetClass:Field(Name, Type, Send, Receive, Mode, Channel)
	
	if Name then
		
	end
	
end

function NetClass:SetSenderAttribute(Name, Sender)
	
	if Name then
		
		local Attribute = self.Attributes[Name]
		
		if Attribute then
			
			Attribute.Send = Sender
			
		end
		
	end
	
end

function NetClass:GetSenderAttribute(Name)
	
	if Name then
		
		local Attribute = self.Attribute[Name]
		
		if Attribute then
			
			return Attribute.Send
			
		end
		
	end
	
end