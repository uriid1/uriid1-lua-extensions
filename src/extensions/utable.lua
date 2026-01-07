--- Table utilities
-- @module ule.utable

local M = {}

local type = type
local next = next

--- Checking if a table is empty
-- @param t Table
-- @return boolean
function M.isEmpty(t)
  assert(type(t) == 'table', 'isEmpty: argument must be a table')

  return not next(t)
end

--- Checking if it is a table
-- @param t Table
-- @return boolean
function M.isTable(t)
  assert(type(t) == 'table', 'isTable: argument must be a table')

  return type(t) == 'table'
end

--- Checking if a table is an array
-- @param t Table
-- @return boolean
function M.isArray(t)
  assert(type(t) == 'table', 'isArray: argument must be a table')

  local index = 0
  for _,_ in next, t do
    index = index + 1

    if t[index] == nil then
      return false, nil
    end
  end

  return true, index
end

--- Returns the first element of the table like JS
-- @param t Table
-- @return first element or nil
function M.shift(t)
  assert(type(t) == 'table', "shift: argument must be a table")

  return table.remove(t, 1)
end

--- Merging table t2 into t1 (is not deep copy)
-- @param t1 Table
-- @param t2 Table
function M.merge(t1, t2)
  assert(type(t1) == 'table', 'merge: first argument must be a table')
  assert(type(t2) == 'table', 'merge: second argument must be a table')

  for key, value in pairs(t2) do
    if type(value) == 'table' and type(t1[key]) == 'table' then
      M.merge(t1[key], t2[key])
    else
      t1[key] = value
    end
  end

  return t1
end

--- Find value in a table
-- @param t (table) Table
-- @param value (any) Value
-- @return value (any)
function M.find(t, value)
  assert(type(t) == 'table', 'find: argument must be a table')

  for k, v in pairs(t) do
    if v == value then
      return k
    end
  end

  return nil
end

--- Compare t1 and t2
-- @param t1 Table
-- @param t2 Table
function M.compare(t1, t2)
  assert(type(t1) == 'table', 'compare: first argument must be a table')
  assert(type(t2) == 'table', 'compare: second argument must be a table')

  -- Check element count
  local count1 = 0
  for _ in pairs(t1) do
    count1 = count1 + 1
  end

  local count2 = 0
  for _ in pairs(t2) do
    count2 = count2 + 1
  end

  if count1 ~= count2 then
    return false
  end

  -- Check key value
  for key, value in pairs(t1) do
    if type(value) == 'table' then
      if type(t2[key]) ~= 'table' or not M.compare(value, t2[key]) then
        return false
      end
    else
      if value ~= t2[key] then
        return false
      end
    end
  end

  return true
end

--- Reverse the table
-- @param t Table
-- @return table
function M.reverse(t)
  assert(type(t) == 'table', 'reverse: argument must be a table')

  local tbl = {}
  for i = #t, 1, -1 do
    table.insert(tbl, #tbl+1, t[i])
  end

  return tbl
end

--- Fills all elements of the array from the start to the end(done) indexes with a single value
-- @param t Table
-- @param value Value
-- @param start Start of fill
-- @param done End of fill
function M.fill(t, value, start, done)
  assert(type(t) == 'table', 'fill: argument must be a table')

  for i = start, done do
    t[i] = value
  end
  return t
end

--- Returns a string representation of array elements
-- @param t Table
-- @param sep Separator
-- @param start Start
-- @param done End
-- @return table
function M.toString(t, sep, start, done)
  assert(type(t) == 'table', 'toString: argument must be a table')

  return table.concat(t, sep or ',', start or 1, done or #t)
end

--- Shuffles the table
-- @param t Table
function M.shake(t)
  assert(type(t) == 'table', 'shake: argument must be a table')

  for i = #t, 1, -1 do
    local rnd_index = math.random(i)
    t[rnd_index], t[i] = t[i], t[rnd_index]
  end
end

--- Gets the count of duplicates in an array
-- @param arr (table) Array
-- @return number of duplicates
function M.getSumDupl(arr)
  assert(type(arr) == 'table', 'getSumDupl: argument must be a table')

  local seen = {}

  for x = 1, #arr do
    local val = arr[x]
    if not seen[val] then
      seen[val] = 1
    else
      seen[val] = seen[val] + 1
    end
  end

  local sum = 0
  for _, val in next, seen do
    if val > 1 then
      sum = sum + val
    end
  end

  return sum
end

--- Fills an array with unique random numbers
-- @param len (number) The length of the array
-- @param range (number) The maximum range of values, must be greater than arr_len
-- @return Array with unique values
function M.genUniqNum(len, range)
  if range < len then
    return nil
  end

  -- pool = {1, 2, ..., range}
  local pool = {}
  for i = 1, range do
    pool[i] = i
  end

  -- Fisher–Yates shuffle
  for i = range, 2, -1 do
    local j = math.random(i)  -- j in [1, i]
    pool[i], pool[j] = pool[j], pool[i]
  end

  local result = {}
  for i = 1, len do
    result[i] = pool[i]
  end

  return result
end

return M
