<h1 align='center'>runner.nvim</h1>

`runner.nvim` executes file from current buffer and displays result in a new scratch buffer.
## Installation:
Lazy:
```lua
"9th8/runner.nvim"
```

## Example Lua Config:
```lua
require('runner.nvim').setup{
  cmds = {
    perl = "perl %",
    fish = "fish %",
    sh   = "sh %"
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
