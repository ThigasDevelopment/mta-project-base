---@class Module : ModuleAPI, ClassDefinition

---@class Core
---@field threads? Threads
---@field modules table<string, any>
---@field load fun(self: Core): void
---@field init fun(self: Core): void