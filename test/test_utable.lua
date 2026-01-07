package.path = package.path .. ';.rocks/share/lua/5.1/?.lua'
package.path = package.path .. ';.rocks/share/lua/5.1/?/init.lua'
package.path = package.path .. ';src/extensions/?.lua'

local lu = require('luaunit')
local utable = require('utable')

-- luacheck: ignore self
-- luacheck: ignore tests
tests = {}

-- isEmpty
function tests:testIsEmpty()
  lu.assertTrue(utable.isEmpty({}))
  lu.assertFalse(utable.isEmpty({ 1, 2, 3}))
end

function tests:testIsEmptyAssert()
  local status, err = pcall(utable.isEmpty, 'not a table')

  lu.assertFalse(status)
  lu.assertStrContains(err, 'isEmpty: argument must be a table')
end

-- isTable
function tests:testIsTable()
  lu.assertTrue(utable.isTable({}))
end

function tests:testIsTableAssert()
  local status, err = pcall(utable.isTable, 123)

  lu.assertFalse(status)
  lu.assertStrContains(err, 'isTable: argument must be a table')
end

-- isArray
function tests:testIsArray()
  local ok, len = utable.isArray({1,2,3})
  lu.assertTrue(ok)
  lu.assertEquals(len, 3)

  local ok2, len2 = utable.isArray({[1]=1, [3]=2})
  lu.assertFalse(ok2)
end

-- shift
function tests:testShift()
  local t = {1,2,3}
  local first = utable.shift(t)
  lu.assertEquals(first, 1)
  lu.assertEquals(#t, 2)
end

-- merge
function tests:testMerge()
  local t1 = { a = 1, b = { c = 2 } }
  local t2 = { b = { d = 3 }, e = 4 }
  local merged = utable.merge(t1, t2)

  lu.assertEquals(merged.a, 1)
  lu.assertEquals(merged.b.c, 2)
  lu.assertEquals(merged.b.d, 3)
  lu.assertEquals(merged.e, 4)
end

-- find
function tests:testFind()
  local t = { a = 1, b = 2 }
  lu.assertEquals(utable.find(t,2), 'b')
  lu.assertEquals(utable.find(t,3), nil)
end

-- compare
function tests:testCompare()
  local t1 = { a = 1, b = { c = 2 } }
  local t2 = { a = 1, b = { c = 2 } }
  lu.assertTrue(utable.compare(t1, t2))
  t2.b.c = 3
  lu.assertFalse(utable.compare(t1, t2))
end

-- reverse
function tests:testReverse()
  local t = { 1, 2, 3 }
  local rev = utable.reverse(t)
  lu.assertEquals(rev[1], 3)
  lu.assertEquals(rev[3], 1)
end

-- fill
function tests:testFill()
  local t = { 0, 0, 0 }
  utable.fill(t, 5, 1, 3)
  lu.assertEquals(t, { 5, 5, 5 })
end

-- toString
function tests:testToString()
  local t = { 1, 2, 3 }
  lu.assertEquals(utable.toString(t, '-'), '1-2-3')
end

-- shake
function tests:testShake()
  local t = { 1, 2, 3, 4, 5 }
  utable.shake(t)
  lu.assertEquals(#t, 5)
end

-- getSumDupl
function tests:testGetSumDupl()
  local t = { 1, 2, 2, 3, 3, 3 }
  lu.assertEquals(utable.getSumDupl(t), 5)
end

-- genUniqNum
function tests:testGenUniqNum()
  local arr = utable.genUniqNum(5, 10)

  lu.assertEquals(#arr, 5)
  local seen = {}
  for _,v in ipairs(arr) do
    lu.assertNil(seen[v])
    seen[v] = true
  end
end

-- os.exit(lu.run())
