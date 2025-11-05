--- Math utilities
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
-- Example: choosing 4 books from 6, where order matters.
-- @param n (number) Total elements
-- @param k (number) Chosen elements
-- @return (number) Number of arrangements
-- @usage
-- print(M.placement(6, 4)) -- 360
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

--- Split a number into integer and fractional parts
-- @param n (number) Input value
-- @return (integer) Integer part
-- @return (number) Fractional part
-- @usage
-- local int, frac = M.splitIntDec(12.34)
-- print(int, frac) -- 12  0.34
function M.splitIntDec(n)
  local integer = math.floor(n)
  return integer, n - integer
end

--- Normalize a value from one range into another
-- Maps an input value proportionally from `[0, max_value]` to `[out_range_min, out_range_max]`
-- @param value (number) Current value
-- @param max_value (number) Maximum input value
-- @param out_range_min (number) Minimum output range value
-- @param out_range_max (number) Maximum output range value
-- @return (number) Scaled value
-- @usage
-- print(M.normalizeRange(50, 100, 0, 1)) -- 0.5
function M.normalizeRange(value, max_value, out_range_min, out_range_max)
  -- Масштабирование значения входного диапазона: (value / max_value)
  -- Масштабирование нормализованного значения к выходному диапазону
  return out_range_min + (value / max_value) * (out_range_max - out_range_min)
end

--- Choose a random value from a variable list.
-- @param (...) any One or more values
-- @return (any) Randomly selected value
-- @usage
-- print(M.choose("a", "b", "c"))
function M.choose(...)
  local r = select(
    math.random(select('#', ...)),
    ...
  )
  return r
end

return M
