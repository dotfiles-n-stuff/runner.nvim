<h1 align='center'>runner.nvim</h1>

`runner.nvim` executes file from current buffer and displays result in a new scratch buffer.
## Installation:
Lazy:
```lua
"9th8/runner.nvim"
```

## Example Lua Config:
```lua
require "runner".setup {
  cmds = {
    fish = "fish %",
    lua  = "lua %",
    ruby = "ruby -w %",
    sh   = "sh %"
  },
  profile = {
    ruby = "ruby-prof %"
  },
  repl = {
  },
  debug = {
    ruby = "rdbg %"
  },
  behavior = {
    autosave = true
  }
} 
```

## Usage:

```
:RunnerLaunch
```
