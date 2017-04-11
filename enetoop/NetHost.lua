local Library = ...

NetHost = {}
NetHost.__index = NetHost
NetHost.__type = NetHost

NetHost.WeakTable = {__mode == "k"}

function NetHost:new(Port)
	
	local self = setmetatable({}, NetHost)
	
	self.Host = Library.enet.host_create("localhost:"..Port)
	self.Peer = {}
	
	self.NetObject = setmetatable({}, self.WeakTable)
	
	return self
	
end

function NetHost:SendObject(Peer, Object)
	
	local NetObject = self.NetObject[Object]
	
	if not NetObject then
		
		NetObject = self:Instantiate(Object)
		
	end
	
	NetObject:GrantAccess(Peer)
	
end

function NetHost:ReceiveObject()
	
	local Index, Object = next(self.Unreceived)
	
	if Object then
		
		self.Unreceived[Index] = nil
		
		return Object
		
	end
	
end

function NetHost:Update()
	
	for Index, Object in pairs(self.NetObject) do
		
		Object:Update()
		
	end
	
	local Event
	
	repeat
		
		Event = self.Host:service()
		
		if Event then
			
			local Index = Event.peer:index()
			
			if Event.type == "connect" then
				
				self.Peer[Index] = NetPeer:new(self, Event.peer)
				
			elseif Event.type == "disconnect" then
				
				self.Peer[Index] = nil
				
			elseif Event.type == "receive" then
				
				self.Peer[Index]:Receive(Event.data)
				
			end
			
		end
		
	until Event == nil
	
	self.Host:flush()
	
end

function NetHost:Instantiate(Object)
	
	local NetObj = self.NetObject[Object]
	
	if not NetObj then
		
		local NetObj = NetObject:new(Object)
		
		self.NetObject[Object] = NetObj
		
	end
	
	return NetObj
	
end

function NetHost:NetObjectCollected(NetObject)
	
end