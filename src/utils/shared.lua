---@type boolean
IS_CLIENT_SIDE = isElement (localPlayer);

---@param t table
---@return number
function table.size (t)
	local size = 0;

	local tType = type (t);
	if (tType ~= 'table') then
		return size;
	end

	for _ in pairs (t) do
		size = (size + 1);
	end
	return size;
end