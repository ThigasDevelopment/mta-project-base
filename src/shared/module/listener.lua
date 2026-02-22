---@class Listener
---@field core Core
---@field event Event
---@field handle fun(self: Listener, ...): void
class 'Listener' {
	---@param self Listener
	---@param core Core
	---@param params EventParams
	---@return Listener
	constructor = function (self, core, params)
		self.core = core;

		self.event = Event (self.core, {
			name = params.name,
			attachedTo = params.attachedTo,

			handler = bind (self.handle, self),
			remote = params.remote,
		});

		return self;
	end,

	---@param self Listener
	---@param ... any
	---@return void
	handle = function (self, ...)
		-- Override this method to handle the event.
	end,
};