--- Benchmark and function testing utilities
-- @module ule.test
local M = {}

local unpack = unpack or table.unpack

local DEFAULT_MAX_SEEN = 1000

--- Internal cache for resolved function names.
-- @local
local seenArg = {}

local function findNameByAddr(addr, level)
  if seenArg[addr] then
    return seenArg[addr]
  end

  -- Find local name by addr
  for i = 1, DEFAULT_MAX_SEEN do
    local name, value = debug.getlocal(level, i)
    if not name and not value then
      break
    end

    if value == addr then
      seenArg[addr] = name
      return name
    end
  end

  -- Find global name by addr
  for name, value in pairs(_G) do
    if value == addr then
      seenArg[addr] = name
      return name
    end
  end

  return nil
end

--- Find a variable name by its memory address
-- Searches among local variables and global environment
-- @local
-- @param addr function|table Reference to locate
-- @param level number Stack level for `debug.getlocal`
-- @return string|nil Variable name if found
function M.bench(param)
  param.count = param.count or 1
  local summary
  for _ = 1, param.count do
    local start = os.clock()
    if param.args then
      param.func(unpack(param.args))
    else
      param.func()
    end
    summary = os.clock() - start
  end

  if param and param.print then
    local level = param.level or 2
    local name = findNameByAddr(param.func, level+1) or 'nil'
    print(
      string.format(
        'Function: %s | Count %d | Duration %s',
        name, param.count, summary
        )
    )
  end

  return summary
end

return M
