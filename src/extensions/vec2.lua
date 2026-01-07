--- Vector 2D class
-- @classmod vec2

local vec2 = {}
vec2.__index = vec2

--- Create a new vec2
-- @param x X coordinate (default: 0)
-- @param y Y coordinate (default: 0)
-- @return A new vec2 instance
function vec2:new(x, y)
  local v = setmetatable({}, self)

  v.x = x or 0
  v.y = y or 0

  return v
end

--- Set the coordinates of the vector
-- @param x X coordinate (optional)
-- @param y Y coordinate (optional)
function vec2:set(x, y)
  self.x = x or self.x
  self.y = y or self.y
end

--- Add another vector to this vector
-- @param vec A vec2 instance to add
function vec2:add(vec)
  self.x = self.x + vec.x
  self.y = self.y + vec.y
end

--- Subtract another vector from this vector.
-- @param vec A vec2 instance to subtract
function vec2:sub(vec)
  self.x = self.x - vec.x
  self.y = self.y - vec.y
end

--- Calculate the squared magnitude of the vector
-- @return The squared magnitude
function vec2:sqrMagnitude()
  return self.x * self.x + self.y * self.y
end

--- Calculate the magnitude (length) of the vector
-- @return The magnitude
function vec2:magnitude()
  return math.sqrt(self:sqrMagnitude())
end

--- Create a clone of this vector.
-- @return A new vec2 instance with the same coordinates
function vec2:clone()
  return vec2.new(self.x, self.y)
end

--- Normalize the vector.
function vec2:normalize()
  local d = self:magnitude()

  if d > 0 then
    self.x = self.x / d
    self.y = self.y / d
  end
end

--- Multiply the vector by a scalar
-- @param d The scalar value
-- @return A new vec2 instance
function vec2:mul(d)
  return vec2:new(self.x * d, self.y * d)
end

--- Create a clone of this vector.
-- @return A new vec2 instance with the same coordinates
function vec2:clone()
  return vec2:new(self.x, self.y)
end

--- Vector-scalar multiplication metamethod
function vec2.__mul(a, b)
  if type(a) == 'number' then
    return b:mul(a)
  elseif type(b) == 'number' then
    return a:mul(b)
  else
    error('Multiplication must be vec2 * number or number * vec2')
  end
end

--- Vector addition metamethod.
function vec2.__add(a, b)
  return vec2:new(a.x + b.x, a.y + b.y)
end

--- Vector subtraction metamethod.
function vec2.__sub(a, b)
  return vec2:new(a.x - b.x, a.y - b.y)
end

--- String representation.
function vec2:__tostring()
  return string.format('vec2(%.3f, %.3f)', self.x, self.y)
end

return vec2
