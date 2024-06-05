---
-- Module for working with trigenometry.
-- @module ule.ustrig

local M = {}

---
-- lengthdirX
-- @param length Length
-- @param direction Direction
-- @return float
function M.lengthdirX(length, direction)
  return length * math.cos(direction)
end

---
-- lengthdirY
-- @param length Length
-- @param direction Direction
-- @return float
function M.lengthdirY(length, direction)
  return length * math.sin(direction)
end

---
-- distance2point
-- @param x1 x1
-- @param y1 y1
-- @param x2 x2
-- @param y2 y2
-- @return float
function M.distance2point(x1, y1, x2, y2)
  return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)
end

return M
