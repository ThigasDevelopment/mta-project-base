---@class Commands
---@field core Core
---@field load fun(self: Commands): void
class 'Commands' {
	---@param self Commands
	---@param core Core
	---@return Commands
	constructor = function (self, core)
		self.core = core;

		return self;
	end,

	---@param self Commands
	---@return void
	load = function (self)
		local classes = getClasses ();
		for name, class in pairs (classes) do
			local extends = class.__super;
			if (extends) and (extends.__name == 'Command') then
				class:constructor (self.core);
			end
		end
	end,
};

---@type fun(core: Core): Commands
Commands = new 'Commands';