---@class Listeners
---@field load fun(self: Listeners): void
class 'Listeners' {
	---@param self Listeners
	---@param core Core
	---@return Listeners
	constructor = function (self, core)
		self.core = core;
		return self;
	end,

	---@param self Listeners
	---@return void
	load = function (self)
		local classes = getClasses ();
		for name, class in pairs (classes) do
			local extends = class.__super;
			if (extends) and (extends.__name == 'Listener') then
				class:constructor (self.core);
			end
		end
	end,
};

---@type fun(core: Core): Listeners
Listeners = new 'Listeners';