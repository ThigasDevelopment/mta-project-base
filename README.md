# MTA:SA Script Base

This repository serves as my personal script base/boilerplate for Multi Theft Auto (MTA) resources. It is designed to provide a solid foundation for developing scalable and modular scripts.

## Overview

- **Modular Structure**: Organized into client, server, and shared environments.
- **Utility Libraries**: Includes helper functions and classes to streamline development.
  - **`class.lua`**: Object-Oriented Programming support, sourced from [ThigasDevelopment/lua-class](https://github.com/ThigasDevelopment/lua-class).
  - **`threads.lua`**: Coroutine-based thread management, sourced from [ThigasDevelopment/mta-threads](https://github.com/ThigasDevelopment/mta-threads).

## Future Plans

I am currently working on expanding the core functionality. Planned features include:

- **Event Modules**: A robust system for handling custom events.
- **Extended Utilities**: More tools to simplify common MTA tasks.
- **Documentation**: Detailed guides and API references will be added as new modules are implemented.

## Project Structure

```
.
├── config.lua          # General configuration
├── meta.xml            # Resource metadata
├── src/
│   ├── client/         # Client-side logic
│   │   └── index.lua   # Client entry point. Listens to 'onClientResourceStart' and initializes the Core.
│   ├── server/         # Server-side logic
│   │   └── index.lua   # Server entry point. Listens to 'onResourceStart' and initializes the Core.
│   ├── shared/         # Shared code (accessible by both)
│   │   └── core.lua    # The heart of the project. Defines the main Core class that manages modules and initialization.
│   └── utils/          # Utility functions and type definitions
```

### Core Architecture

The project uses an Object-Oriented approach to keep the codebase clean and modular:

- **`src/shared/core.lua`**: This is the main manager. It defines the `Core` class, which is responsible for holding and loading all future modules (events, utilities, etc.). It also initializes a thread manager if running on the client side.
- **`src/server/index.lua` & `src/client/index.lua`**: These are the entry points for the server and client, respectively. When the resource starts (`onResourceStart` / `onClientResourceStart`), they instantiate the `Core` class and call its `init()` method, which in turn loads the rest of the project.

> **Note**: This project is a work in progress. Documentation and features will be updated as the base evolves.
