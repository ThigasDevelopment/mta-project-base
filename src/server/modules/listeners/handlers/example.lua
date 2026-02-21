---@class LoadedListener : Listener
---@field core Core
class 'LoadedListener' : extends 'Listener' {
	---@param self LoadedListener
	---@param core Core
	---@return LoadedListener
	constructor = function (self, core)
		self.core = core;

		self:super (self.core, {
			name = 'onPlayerResourceStart',
			attachedTo = root,
		});
		return self;
	end,

	---@param self LoadedListener
	---@param startedRes userdata
	---@return void
	handle = function (self, startedRes)
		if (startedRes ~= resource) then return end

		print (inspect (source) .. ': has loaded client - side files.');
	end,
};