local M = {}

local config = {
  cmds = {},
  debug = {},
  behavior = {
    autosave = false
  }
}

function M.setup(user_opts)
  config = vim.tbl_deep_extend("force", config, user_opts)
end

local function substitute(cmd)
  cmd = cmd:gsub("%%", vim.fn.expand('%'));
  cmd = cmd:gsub("$fileBase", vim.fn.expand('%:r'));
  cmd = cmd:gsub("$filePath", vim.fn.expand('%:p'));
  cmd = cmd:gsub("$file", vim.fn.expand('%'));
  cmd = cmd:gsub("$dir", vim.fn.expand('%:p:h'));
  cmd = cmd:gsub("$moduleName",
    vim.fn.substitute(vim.fn.substitute(vim.fn.fnamemodify(vim.fn.expand("%:r"), ":~:."), "/", ".", "g"), "\\", ".",
      "g"));
  cmd = cmd:gsub("#", vim.fn.expand('#'))
  cmd = cmd:gsub("$altFile", vim.fn.expand('#'))
  return cmd
end

function M.launch()
  cmd = config.cmds[vim.bo.filetype]
  run(cmd)
end

function M.debug()
  cmd = config.debug[vim.bo.filetype]
  run(cmd)
end

function M.profile()
  cmd = config.profile[vim.bo.filetype]
  run(cmd)
end

function run(cmd)
  if not cmd then
    vim.cmd("echohl ErrorMsg | echo 'Error: Invalid command' | echohl None")
    return
  end

  if config.behavior.autosave then vim.cmd("silent write") end

  cmd = substitute(cmd)

  vim.cmd(":enew | setlocal buftype=nofile bufhidden=wipe filetype=scratch")

  vim.fn.termopen(cmd)
  vim.cmd(":startinsert!")
end

return M
