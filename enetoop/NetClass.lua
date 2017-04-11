local Library = ...

NetClass = {}
NetClass.__index = NetClass
NetClass.__type = NetClass

function NetClass:new(Class)
	
	if Library.GetRegistry(Class.__type) then
		
		return nil
		
	end
	
	local self = setmetatable({}, NetClass)
	
	self.Attributes = {} 								-- self.Attributes[Name] = {Send = true, Receive = true, Type = some_class.__type, Mode = "reliable", Channel = 0}
	
	Library.Register(Class.__type, Class)
	
	return self
	
end

function NetClass:Attribute(Name, Type, Send, Receive, Mode, Channel)
	
	if Name then
		
		self.Attributes[Name] = NetAttribute:new(self, Name, Type, Send, Receive, Mode, Channel)
		
	end
	
	return self
	
end

function NetClass:GetAttribute(Name)
	
	if Name then
		
		return self.Attributes[Name]
		
	end
	
end

function NetClass:SetAttribute(Name, Attribute)
	
	if Name then
		
		self.Attributes[Name] = Attribute
		
	end
	
end

function NetClass:GetAttributes()
	
	return self.Attributes
	
end

function NetClass:OnSetAttribute(Attribute, Value)
	
end