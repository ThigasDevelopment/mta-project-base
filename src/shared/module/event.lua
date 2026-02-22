---@class EventParams
---@field name string
---@field attachedTo userdata
---@field handler fun(...: any): any
---@field remote? boolean

---@class Event : EventParams
---@field core Core
---@field destructor fun(self: Event): void
class 'Event' {
	---@param self Event
	---@param core Core
	---@param params EventParams
	---@return Event
	constructor = function (self, core, params)
		self.core = core;

		self.name = params.name;
		self.attachedTo = params.attachedTo;
		self.handler = params.handler;

		self.remote = params.remote or false;
		if (self.remote) then
			addEvent (self.name, true);
		end
		addEventHandler (self.name, self.attachedTo, self.handler);

		return self;
	end,

	---@param self Event
	---@return void
	destructor = function (self)
		removeEventHandler (self.name, self.attachedTo, self.handler);
	end,
};

---@type fun(core: Core, params: EventParams): Event
Event = new 'Event';