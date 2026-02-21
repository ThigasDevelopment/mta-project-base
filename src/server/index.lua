addEventHandler ('onResourceStart', resourceRoot,
	function ()
		core = Core ();
		core:init ();
	end
);