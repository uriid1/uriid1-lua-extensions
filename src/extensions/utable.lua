---
-- Module for working with table.
-- @module ule.utable

local M = {}

local type = type
local next = next

--- Checking if a table is empty
-- @param t Table
-- @return boolean
function M.isEmpty(t)
  return not next(t)
end

--- Checking if it is a table
-- @param t Table
-- @return boolean
function M.isTable(t)
  return type(t) == 'table'
end

--- Checking if a table is an array
-- @param t Table
-- @return boolean
function M.isArray(t)
  if type(t) ~= 'table' then
    return false, nil
  end

  local index = 0
  for _,_ in next, t do
    index = index + 1

    if t[index] == nil then
      return false, nil
    end
  end

  return true, index
end

--- Returns the first element of the table, then deletes it by making an offset
-- @param t Table
-- @return first element or empty table
function M.shift(t)
  local tmp = {}
  table.insert(tmp, t[1])
  table.remove(t, 1)
  return tmp[1] or {}
end

--- Merging table t2 into t1 (is not deep copy)
-- @param t1 Table
-- @param t2 Table
function M.merge(t1, t2)
  for key, value in pairs(t2) do
    if type(value) == 'table' and type(t1[key]) == 'table' then
      M.merge(t1[key], t2[key])
    else
      t1[key] = value
    end
  end

  return t1
end

--- Compare t1 and t2
-- @param t1 Table
-- @param t2 Table
function M.compare(t1, t2)
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
  return table.concat(t, sep or ',', start or 1, done or #t)
end

--- Shuffles the table
-- @param t Table
function M.shake(t)
  for i = #t, 1, -1 do
    local rnd_index = math.random(i)
    t[rnd_index], t[i] = t[i], t[rnd_index]
  end
end

--- Gets the count of duplicates in an array
-- @param arr (table) Array
-- @return number of duplicates
function M.getSumDupl(arr)
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
-- Unsupported, the algorithm is not successful
-- @param arr_len (number) The length of the array
-- @param rnd_range (number) The maximum range of values, must be greater than arr_len
-- @return Array with unique values
function M.fillUniqNubersArr(arr_len, rnd_range)
  if rnd_range < arr_len then
    return nil
  end

  local result = {}
  local seen = {}

  for i = 1, arr_len do
    math.randomseed(os.clock())
    local rnd = math.random(rnd_range)

    if seen[rnd] == nil then
      seen[rnd] = true
    else
      local tmpVal = i
      if seen[tmpVal] == nil then
        seen[tmpVal] = true
        rnd = tmpVal
        goto finalize
      end

      local tmpVal = math.max(1, math.min(rnd_range, rnd - 1))
      if seen[tmpVal] == nil then
        seen[tmpVal] = true
        rnd = tmpVal
        goto finalize
      end

      local tmpVal = math.max(1, math.min(rnd_range, rnd + 1))
      if seen[tmpVal] == nil then
        seen[tmpVal] = true
        rnd = tmpVal
        goto finalize
      end

      local newRnd
      local dupl = true
      while dupl do
        math.randomseed(os.clock())
        newRnd = math.random(rnd_range)

        dupl = not (seen[newRnd] == nil)
      end

      rnd = newRnd
      seen[rnd] = true

      ::finalize::
    end

    table.insert(result, rnd)
  end

  return result
end

return M
