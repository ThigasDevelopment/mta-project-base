---@class Listener : Event, ClassDefinition
---@field core Core
---@field handle fun(self: Listener, ...): void
class 'Listener' : extends 'Event' {
	---@param self Listener
	---@param core Core
	---@param params EventParams
	---@return Listener
	constructor = function (self, core, params)
		self.core = core;

		self.onHandle = bind (self.handle, self);
		self:super (self.core, {
			name = params.name,
			attachedTo = params.attachedTo,

			handler = self.onHandle,
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