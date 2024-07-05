--- Модуль для тестирования
-- @module ule.test
local M = {}

local unpack = unpack or table.unpack

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
    param.func(unpack(param.args))
    summary = os.clock() - start
  end

  return summary
end

return M
