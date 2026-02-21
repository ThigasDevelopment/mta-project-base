---@type Core
class 'Core' {
	---@param self Core
	---@return Core
	constructor = function (self)
		self.modules = { };

		if (IS_CLIENT_SIDE) then
			self.threads = Threads.new ();
		end
		return self;
	end,

	---@param self Core
	---@return void
	load = function (self)
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