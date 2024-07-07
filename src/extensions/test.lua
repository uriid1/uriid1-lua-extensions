--- Модуль для тестирования
-- @module ule.test
local M = {}

local unpack = unpack or table.unpack

local DEFAULT_MAX_SEEN = 1000

-- Поиск имени функции по адресу
--
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
--

--- Тестирует скорость выполнения функции
-- @param param Параметры
-- @param param.func Тестируемая функция
-- @param param.args Массив аргументов функции
-- @param param.count Количество вызовов функции
-- @return время за которое выполнился тест
-- @usage
-- bench({ func = print, args = { 'Hello, World!' }, count = 100 })
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
