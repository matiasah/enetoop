local Library = ...

NetObject = {}
NetObject.__index = NetObject
NetObject.__type = "NetObject"

NetObject.WeakTable = {__mode = "v"}

function NetObject:new(Object)
	
	local self = setmetatable({}, NetObject)
	local Metatable = getmetatable(Object)
	
	self.Object = setmetatable({ Object }, self.WeakTable)
	self.Class = Library.GetRegistry( Metatable.__type or Metatable.Type )
	
	-- Peer access array
	self.Access = {}
	
	-- Value array
	self.Value = {}
	self.Changed = {}
	
	local Proxy = newproxy(true)
	local Meta = getmetatable(Proxy)
	
	Meta.__index = self
	Meta.__newindex = self
	Meta.__gc = NetObject.__gc
	
	Object.__netobject = Proxy
	
	return Proxy
	
end

function NetObject:__gc()
	
	for Index, NetPeer in pairs(self.Access) do
		
		NetPeer:AdviseCollected()
		
	end
	
end

function NetObject:Update()
	
	for Name, Attribute in pairs( self.Class:GetAttributes() ) do
		
		if Attribute:HasChanged( self ) then
			
			table.insert(self.Changed, Name)
			
			self.Value[Name] = self.Object[1][Name]
			
		end
		
	end
	
	if next(self.Changed) then
		
		for Index, NetPeer in pairs(self.Access) do
			
			NetPeer:AdviseAttributes(self, self.Changed)
			
		end
		
		self.Changed = {}
		
	end
	
end

function NetObject:GetValue(Name)
	
	return self.Value[Name]
	
end

function NetObject:SetValue(Name, Value)
	
	self.Value[Name] = Value
	
end

function NetObject:GetObject()
	
	return self.Object[1]
	
end

function NetObject:GrantAccess(WhatPeer)
	
	for Index, Peer in pairs(self.Access) do
		
		if Peer = WhatPeer then
			
			return true
			
		end
		
	end
	
	WhatPeer:Instantiate(self)
	
	table.insert(self.Access, WhatPeer)
	
	return true
	
end

function NetObject:RevokeAccess(WhatPeer)
	
	for Index, Peer in pairs(self.Access) do
		
		if Peer == WhatPeer then
			
			self.Access[Index] = nil
			
			break
			
		end
		
	end
	
	WhatPeer:Release(self)
	
end