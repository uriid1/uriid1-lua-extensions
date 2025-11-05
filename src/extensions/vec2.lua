--- Vector 2D class
-- @classmod vec2

local vec2 = {}
vec2.__index = vec2

--- Create a new vec2.
-- @param x X coordinate (default: 0)
-- @param y Y coordinate (default: 0)
-- @return A new vec2 instance
function vec2:new(x, y)
  local v = setmetatable({}, self)

  v.x = x or 0
  v.y = y or 0

  return v
end

--- Set the coordinates of the vector.
-- @param x X coordinate (optional)
-- @param y Y coordinate (optional)
function vec2:set(x, y)
  self.x = x or self.x
  self.y = y or self.y
end

--- Add another vector to this vector.
-- @param vec A vec2 instance to add
function vec2:add(vec)
  self.x = self.x + vec.x
  self.y = self.y + vec.y
end

--- Calculate the squared magnitude of the vector.
-- @return The squared magnitude
function vec2:sqr_magnitude()
  return self.x * self.x + self.y * self.y
end

--- Create a clone of this vector.
-- @return A new vec2 instance with the same coordinates
function vec2:clone()
  return vec2.new(self.x, self.y)
end

--- Normalize the vector.
function vec2:normalize()
  local d = math.sqrt(self.x * self.x + self.y * self.y)

  local vx = self.x / d
  local vy = self.y / d

  if vx == vx then
    self.x = vx
  end
  if vy == vy then
    self.y = vy
  end
end

--- Multiply the vector by a scalar.
-- @param vec The vector to multiply
-- @param d The scalar value
-- @return The multiplied vector
function vec2.__mul(vec, d)
  vec.x = vec.x * d
  vec.y = vec.y * d

  return vec
end

return vec2
