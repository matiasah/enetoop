local Library = ...

NetPeer = {}
NetPeer.__index = NetPeer
NetPeer.__type = "NetPeer"

NetPeer.WeakTable = {__mode == "k"}

function NetPeer:new(NetHost, Peer)
	
	local self = setmetatable({}, NetPeer)
	
	self.NetHost = NetHost
	self.Peer = Peer
	
	self.NetObject = setmetatable({}, self.WeakTable)
	self.NetReservationQueue = {}
	self.Unreceived = {}
	
	return self
	
end

function NetPeer:Receive(Datagram)
	
	local Type = Datagram:byte(1)
	
	if Type == 1 then
		
		-- Object created
		
	end
	
end

function NetPeer:Contains(NetObject)
	
	for Index, Object in pairs(self.NetObject) do
		
		if Object == NetObject then
			
			return Index
			
		end
		
	end
	
	return false
	
end

function NetPeer:Send(Message, Channel, Mode)
	
	self.Peer:send()
	
end

function NetPeer:Instantiate(NetObject)
	
	if not self:Contains(NetObject) then
		
		local Index = #self.NetReservationQueue + 1
		
	end
	
end

function NetPeer:Release(NetObject)
	
end

function NetPeer:AdviseCreated(NetObject)
	
end

function NetPeer:AdviseAttributes(NetObject, Attributes)
	
end

function NetPeer:AdviseCollected(NetObject)
	
end