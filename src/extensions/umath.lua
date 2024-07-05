--- Module for working with math.
-- @module ule.umath

local M = {}

--- Factorial / Permutation (1 * ... * n) | Факториал
-- To calculate the number of permutation options, for example.
-- @param n Number
-- @return number
function M.factorial(n)
  local res = 1
  for i = 1, n do
    res = i * res
  end

  return res
end

--- Arrangement | Выборка
-- Пример:
-- Берем из 6 книг - 4 книги. Порядок имеет значение.
-- Подсчитываем сколько вариантов, разместить эти 4 книги на полке.
-- Между собой 4 книги так же могут меняться.
-- @param n Number
-- @param k Number
-- @return number
function M.placement(n, k)
  return M.factorial(n) / M.factorial(n - k)
end

--- Combination
-- Selection without regard to order
-- @param n Number
-- @param k Number
-- @return number
function M.combination(n, k)
  return M.factorial(n) / (M.factorial(n - k) * M.factorial(k))
end

--- sign
-- @param x int
-- @return integer
function M.sign(x)
  return (x > 0) and 1 or (x == 0 and 0 or -1)
end

--- round
-- @param x int
-- @return integer
function M.round(x)
  return (x >= 0) and math.floor(x + 0.5) or math.ceil(x - 0.5)
end

--- clamp
-- @param val Source value
-- @param val_min Minimal value
-- @param val_max Maximal value
-- @return integer
function M.clamp(val, val_min, val_max)
  return math.max(val_min, math.min(val_max, val))
end

--- lerp
-- @param v0 Source value
-- @param v1 To value
-- @param t Time
-- @return float
function M.lerp(v0, v1, t)
  return v0 * (1.0 - t) + t * v1
end

--- Разделение целого и дробного числа
-- @param n Number
-- @return[1] integer
-- @return[2] decimal
function M.splitIntDec(n)
  local integer = math.floor(n)
  return integer, n - integer
end

--- Приведение одного диапазона к другому
-- @param value Number Текущее значение
-- @param max_value Number Максимальное значение
-- @param out_range_min Number Выходное минимальное значение для диапазона
-- @param out_range_max Number Выходное максимальное значение для диапазона
function M.normalizeRange(value, max_value, out_range_min, out_range_max)
  -- Масштабирование значения входного диапазона: (value / max_value)
  -- Масштабирование нормализованного значения к выходному диапазону
  return out_range_min + (value / max_value) * (out_range_max - out_range_min)
end

return M
