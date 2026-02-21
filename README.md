# MTA:SA Script Base

This repository serves as my personal script base/boilerplate for Multi Theft Auto (MTA) resources. It is designed to provide a solid foundation for developing scalable and modular scripts.

## Overview

- **Modular Structure**: Organized into client, server, and shared environments.
- **Utility Libraries**: Includes helper functions and classes to streamline development.
  - **`class.lua`**: Object-Oriented Programming support, sourced from [ThigasDevelopment/lua-class](https://github.com/ThigasDevelopment/lua-class).
  - **`threads.lua`**: Coroutine-based thread management, sourced from [ThigasDevelopment/mta-threads](https://github.com/ThigasDevelopment/mta-threads).

## Future Plans

I am currently working on expanding the core functionality. Planned features include:

- **Extended Utilities**: More tools to simplify common MTA tasks.
- **Documentation**: Detailed guides and API references will be added as new modules are implemented.

## Project Structure

```
├── config.lua          # General configuration
├── LICENSE             # MIT License
├── meta.xml            # Resource metadata
├── README.md           # Project documentation
└── src/
    ├── client/         # Client-side logic
    │   ├── index.lua   # Client entry point. Listens to 'onClientResourceStart' and initializes the Core.
    │   └── modules/
    │       └── listeners/
    │           ├── index.lua
    │           └── handlers/
    ├── server/         # Server-side logic
    │   ├── index.lua   # Server entry point. Listens to 'onResourceStart' and initializes the Core.
    │   └── modules/
    │       └── listeners/
    │           ├── index.lua
    │           └── handlers/
    │               └── example.lua
    ├── shared/         # Shared code (accessible by both)
    │   ├── core.lua    # The heart of the project. Defines the main Core class that manages modules and initialization.
    │   └── module/
    │       ├── event.lua
    │       └── listener.lua
    └── utils/          # Utility functions and type definitions
        ├── shared.lua
        ├── lib/
        │   ├── class.lua
        │   └── threads.lua
        └── types/
            └── custom.d.lua
```

### Core Architecture

The project uses an Object-Oriented approach to keep the codebase clean and modular:

- **`src/shared/core.lua`**: This is the main manager. It defines the `Core` class, which is responsible for holding and loading all future modules (events, utilities, etc.). It also initializes a thread manager if running on the client side.
- **`src/server/index.lua` & `src/client/index.lua`**: These are the entry points for the server and client, respectively. When the resource starts (`onResourceStart` / `onClientResourceStart`), they instantiate the `Core` class and call its `init()` method, which in turn loads the rest of the project.

### Shared Modules

The `shared` folder contains the core logic and base classes used by both the client and server sides. It is divided into the following parts:

- **`shared/core.lua`**: The heart of the project. It defines the `Core` class, which acts as the main manager. The `Core` is responsible for initializing modules (such as the event/listener manager) and, on the client side, initializing the thread manager.
- **`shared/module/event.lua`**: Defines the `Event` class, which acts as a wrapper for MTA's native event functions (`addEvent` and `addEventHandler`). It simplifies event creation by allowing you to define the name, the attached element (`attachedTo`), the callback function (`handler`), and whether the event is remote (`remote`).
- **`shared/module/listener.lua`**: Defines the `Listener` class, which extends the `Event` class. It is designed to be the base class for all event handlers in the project. The `Listener` automatically binds the `handle` method (which must be overridden in child classes) to the specified event.

### How the Listener Loads Events

The event system is built to be automatic and object-oriented. The loading process works as follows:

1. **Handler Creation**: You create a new class in the `handlers` folder (e.g., `example.lua`) that extends the `Listener` class. In the constructor, you call `self:super()` passing the event configurations (name and the element it is attached to) and override the `handle` method.
2. **Core Initialization**: When the resource starts, the `Core` is instantiated and calls the `load()` method, which in turn initializes the `Listeners` class (located in `modules/listeners/index.lua`).
3. **Automatic Loading**: The `Listeners` class has a `load()` method that uses the `getClasses()` function (from the OOP library) to iterate over all registered classes in the script.
4. **Event Registration**: During the iteration, if the current class extends the `Listener` class (i.e., `class.__super.__name == 'Listener'`), the system automatically instantiates it by calling its constructor and passing the `Core` instance. This causes the event to be registered in MTA and the `handle` method to be set as the official callback for that event.

### Examples

#### 1. Creating a Listener (Recommended)
The best way to handle events is by creating a new class that extends `Listener` inside the `handlers` folder. It will be automatically loaded by the system.

```lua
---@class PlayerJoinListener : Listener
---@field core Core
class 'PlayerJoinListener' : extends 'Listener' {
	---@param self PlayerJoinListener
	---@param core Core
	---@return PlayerJoinListener
	constructor = function (self, core)
		self.core = core;

		-- Initialize the listener with the event details
		self:super (self.core, {
			name = 'onPlayerJoin',
			attachedTo = root,
			-- remote = true -- Uncomment if it's a custom event triggered from the client
		});
		return self;
	end,

	---@param self PlayerJoinListener
	---@return void
	handle = function (self)
		-- 'source' is the player who joined
		print (getPlayerName(source) .. ' has joined the server!');
	end,
};
```

#### 2. Creating an Event Manually
If you need to create an event manually without the automatic listener system, you can use the `Event` class directly:

```lua
---@class Interface
---@field core Core
---@field event Event | nil
---@field render fun(self: Interface): void
---@field toggle fun(self: Interface): void
class 'Interface' {
	---@param self Interface
	---@param core Core
	---@return Interface
	constructor = function (self, core)
		self.core = core;

    self.onRender = bind (self.render, self);
    setTimer (
      function ()
        self:toggle ();
      end, 2000, 0
    );

		return self;
	end,

  ---@param self Interface
  ---@return void
  render = function ()
      local tick = getTickCount ();

      dxDrawRectangle (0, 0, 500, 500, 0xFFFFFF, false);
      dxDrawText ('RENDERER', 0, 0, 500, 500, 0x000000, 1, 'default-bold', 'center', 'center');
  end,

  ---@param self Interface
  ---@return void
  toggle = function (self)
    if (self.event) then
        self.event:destructor ()
        self.event = nil;
    else
        self.event = Event (self.core, {
          name = 'onClientRender',
          attachedTo = root,

          handler = self.onRender,
          remote = false,
        });
    end
  end,
};

---@type fun(core: Core): Interface
Interface = new 'Interface';

local myInterface = Interface (core);
```

---

<div align="center">
  <p>
    Developed with ❤️ by <a href="https://github.com/ThigasDevelopment">ThigasDevelopment</a>
  </p>
  <p>
    <i>This project is open-source and available under the MIT License. Feel free to contribute!</i>
  </p>
</div>
