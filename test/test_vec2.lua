package.path = package.path .. ';.rocks/share/lua/5.1/?.lua'
package.path = package.path .. ';.rocks/share/lua/5.1/?/init.lua'
package.path = package.path .. ';src/extensions/?.lua'

local luaunit = require('luaunit')
local vec2 = require('vec2')

-- luacheck: ignore self
-- luacheck: ignore tests
tests = {}

function tests:testNewDefaults()
  local v = vec2:new()
  luaunit.assertEquals(v.x, 0)
  luaunit.assertEquals(v.y, 0)
end

function tests:testSetPartial()
  local v = vec2:new(1, 2)
  v:set(5)
  luaunit.assertEquals(v.x, 5)
  luaunit.assertEquals(v.y, 2)
end

function tests:testCloneIndependence()
  local v = vec2:new(3, 4)
  local c = v:clone()
  c.x = 10
  luaunit.assertEquals(v.x, 3)
end

function tests:testSqrMagnitude()
  local v = vec2:new(3, 4)
  luaunit.assertEquals(v:sqrMagnitude(), 25)
end

function tests:testMagnitude()
  local v = vec2:new(3, 4)
  luaunit.assertAlmostEquals(v:magnitude(), 5, 1e-9)
end

function tests:testNormalize()
  local v = vec2:new(3, 4)
  v:normalize()
  luaunit.assertAlmostEquals(v.x, 0.6, 1e-9)
  luaunit.assertAlmostEquals(v.y, 0.8, 1e-9)
end

function tests:testNormalizeZeroVector()
  local v = vec2:new(0, 0)
  v:normalize()
  luaunit.assertEquals(v.x, 0)
  luaunit.assertEquals(v.y, 0)
end

function tests:testAddMethod()
  local a = vec2:new(1, 2)
  a:add(vec2:new(3, 4))
  luaunit.assertEquals(a.x, 4)
  luaunit.assertEquals(a.y, 6)
end

function tests:testSubMethod()
  local a = vec2:new(5, 6)
  a:sub(vec2:new(2, 3))
  luaunit.assertEquals(a.x, 3)
  luaunit.assertEquals(a.y, 3)
end

function tests:testAddMetamethod()
  local a = vec2:new(1, 2)
  local b = vec2:new(3, 4)
  local c = a + b
  luaunit.assertEquals(c.x, 4)
  luaunit.assertEquals(c.y, 6)
end

function tests:testSubMetamethod()
  local a = vec2:new(5, 6)
  local b = vec2:new(2, 1)
  local c = a - b
  luaunit.assertEquals(c.x, 3)
  luaunit.assertEquals(c.y, 5)
end

function tests:testMulVectorScalar()
  local v = vec2:new(2, 3)
  local r = v * 2
  luaunit.assertEquals(r.x, 4)
  luaunit.assertEquals(r.y, 6)
end

function tests:testMulScalarVector()
  local v = vec2:new(2, 3)
  local r = 3 * v
  luaunit.assertEquals(r.x, 6)
  luaunit.assertEquals(r.y, 9)
end

function tests:testMulInvalid()
  local v = vec2:new(1, 1)
  local ok = pcall(function()
    return v * vec2:new(1, 1)
  end)
  luaunit.assertFalse(ok)
end

function tests:testMulMethod()
  local v = vec2:new(2, 3)
  local r = v:mul(2)
  luaunit.assertEquals(r.x, 4)
  luaunit.assertEquals(r.y, 6)
  luaunit.assertEquals(v.x, 2)
end

function tests:testToString()
  local v = vec2:new(1, 2)
  luaunit.assertEquals(tostring(v), ('vec2(%.3f, %.3f)'):format(1, 2))
end
