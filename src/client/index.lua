addEventHandler ('onClientResourceStart', resourceRoot,
	---@return void
	function ()
		core = Core ();
		core:init ();
	end
);