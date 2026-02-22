---@type Core
class 'Core' {
	---@param self Core
	---@return Core
	constructor = function (self)
		self.modules = { };
		self.threads = Threads.new ();

		return self;
	end,

	---@param self Core
	---@return void
	load = function (self)
		---@type Commands
		self.modules['commands'] = Commands (self);
		self.modules['commands']:load ();

		---@type Listeners
		self.modules['listeners'] = Listeners (self);
		self.modules['listeners']:load ();
	end,

	---@param self Core
	---@return void
	init = function (self)
		self:load ();
	end,
};

---@type fun(): Core
Core = new 'Core';