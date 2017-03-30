local Library = ...

Library.Classes = {}

function Library.Register(ClassName, NetClass)
	
	if ClasssName then
		
		if Library.Classes[ClassName] then
			
			error('Class "' .. ClassName .. '" already exists')
			
		else
			
			Library.Classes[ClassName] = NetClass
			
		end
		
	end
	
end

function Library.GetRegistry(ClassName)
	
	if ClassName then
		
		return Library.Classes[ClassName]
		
	end
	
end