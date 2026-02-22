---@class CommandParams
---@field name string
---@field handler fun(player: userdata, ...: any): any
---@field aliases? string[]

---@class Command : CommandParams
---@field core Core
class 'Command' {
	---@param self Command
	---@param core Core
	---@param params CommandParams
	---@return Command
	constructor = function (self, core, params)
		self.core = core;

		self.name = params.name;
		self.handler = params.handler;
		self.aliases = params.aliases or { };

		addCommandHandler (self.name, self.handler);
		if (#self.aliases > 0) then
			---@param _ number
			---@param alias string
			for _, alias in pairs (self.aliases) do
				addCommandHandler (alias, self.handler);
			end
		end

		return self;
	end,

	---@param self Command
	---@return void
	destructor = function (self)
		---@param _ number
		---@param alias string
		for _, alias in pairs (self.aliases) do
			removeCommandHandler (alias, self.handler);
		end

		removeCommandHandler (self.name, self.handler);
	end,
};

---@type fun(core: Core, params: CommandParams): Command
Command = new 'Command';