--- Path utilities module
-- @module ule.path
local M = {}

--- Path separator used by the current platform
local SEP = package.config:sub(1, 1)


--- Get a parent directory by depth level
-- Extracts a subpath located above the specified depth
-- @param dir (string) Absolute or relative path
-- @param[opt=1] deep (number) Depth level to go up
-- @return string|nil Subdirectory path or `nil` if no match
function M.getSubDir(dir, deep)
  deep = deep or 1
  local sub_re = "[%w%d_]+"
  -- ^(.-)/[%w%d_]+/?$
  local re = "^(.-)"..SEP..(sub_re..SEP):rep(deep).."?$"

  return dir:match(re)
end

--- Join two paths using the correct separator
-- Avoids duplicate or missing separators
-- @param path_1 string First path
-- @param path_2 string Second path
-- @return string Joined path
function M.join(path_1, path_2)
  local path_1_sep = path_1:sub(-1, -1)
  local path_2_sep = path_2:sub(1, 1)

  local isPath1EqSep = path_1_sep == SEP
  local isPath2EqSep = path_2_sep == SEP

  if not isPath1EqSep and not isPath2EqSep then
    return path_1 .. SEP .. path_2
  end

  return path_1 .. path_2
end

return M
