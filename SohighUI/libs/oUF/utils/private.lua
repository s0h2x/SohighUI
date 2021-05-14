local parent, ns = debugstack():match[[\AddOns\(.-)\]], oUF
local Private = ns.oUF.Private

function Private.argcheck(value, num, ...)
	assert(type(num) == 'number', "Bad argument #2 to 'argcheck' (number expected, got "..type(num)..")")

	for i=1,select("#", ...) do
		if type(value) == select(i, ...) then return end
	end

	local types = strjoin(", ", ...)
	local name = string.match(debugstack(2,2,0), ": in function [`<](.-)['>]")
	error(("Bad argument #%d to '%s' (%s expected, got %s"):format(num, name, types, type(value)), 3)
end

function Private.print(...)
	DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99oUF:|r"..(...))
end

function Private.error(...)
	Private.print("|cffff0000Error:|r "..string.format(...))
end
