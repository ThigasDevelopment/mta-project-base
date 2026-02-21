---@class ModuleAPI
---@field props table
---@field getProps fun(self: ModuleAPI): table
---@field setProps fun(self: ModuleAPI, props: table): ModuleAPI
class 'Module' {
	---@param self ModuleAPI
	---@param props table
	---@return ModuleAPI
	constructor = function (self, props)
		self:setProps (props or { });

		return self;
	end,

	---@param self ModuleAPI
	---@return table
	getProps = function (self)
		return self.props;
	end,

	---@param self ModuleAPI
	---@param props table
	---@return ModuleAPI
	setProps = function (self, props)
		local size = table.size (props);
		if (size > 0) then
			self.props = props;
		end
		return self;
	end,
};