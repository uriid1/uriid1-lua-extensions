local vec2 = {}
vec2.__index = vec2

function vec2:new(x, y)
  local v = setmetatable({}, self)

  v.x = x or 0
  v.y = y or 0

  return v
end

function vec2:set(x, y)
  self.x = x or self.x
  self.y = y or self.y
end

function vec2:add(vec)
  self.x = self.x + vec.x
  self.y = self.y + vec.y
end

function vec2:sqr_magnitude()
  return self.x * self.x + self.y * self.y
end

function vec2:clone()
  return vec2.new(self.x, self.y)
end

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

function vec2.__mul(vec, d)
  vec.x = vec.x * d
  vec.y = vec.y * d

  return vec
end

return vec2
