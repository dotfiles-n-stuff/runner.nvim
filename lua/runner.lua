local M = {}

local config = {
  build = {},
  cmds = {},
  debug = {},
  repl = {},
  profile = {},
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
  local cmd = config.cmds[vim.bo.filetype]
  M.run(cmd, "*launch*")
end

function M.repl()
  local cmd = config.repl[vim.bo.filetype]
  M.run(cmd, "*repl*")
end

function M.debug()
  local cmd = config.debug[vim.bo.filetype]
  M.run(cmd, "*debug*")
end

function M.profile()
  local cmd = config.profile[vim.bo.filetype]
  M.run(cmd, "*profile*")
end

function M.build()
  local cmd = config.build[vim.bo.filetype]
  M.run(cmd, "*build*")
end

function M.run(cmd, console_name)
  if not cmd then
    vim.cmd("echohl ErrorMsg | echo 'Error: Invalid command' | echohl None")
    return
  end

  if config.behavior.autosave then vim.cmd("silent write") end

  cmd = substitute(cmd)

  vim.cmd(":enew | setlocal buftype=nofile bufhidden=wipe filetype=scratch")

  vim.fn.jobstart(cmd, { term = true })
  vim.api.nvim_buf_set_name(0, console_name)
  vim.cmd(":startinsert!")
end

return M
