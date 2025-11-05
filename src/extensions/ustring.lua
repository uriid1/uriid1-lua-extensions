--- String utilities
-- @module ule.ustring

local utf8 = utf8
if not utf8 then
  local res, module = pcall(require, 'utf8')
  if res then
    utf8 = module
  end
end

local M = {}

-- http://lua-users.org/lists/lua-l/2014-04/msg00590.html
function M.utf8Sub(s, i, j)
 i = i or 1
 j = j or -1

 if (i < 1) or (j < 1) then
  local n = utf8.len(s)
  if not n then
    return nil
  end

  if i < 0 then i = n + 1 + i end
  if j < 0 then j = n + 1 + j end
  if i < 0 then i = 1 elseif i > n then i = n end
  if j < 0 then j = 1 elseif j > n then j = n end
 end

  if j < i then
    return ''
  end

   i = utf8.offset(s, i)
   j = utf8.offset(s, j + 1)

   if i and j then return s:sub(i, j - 1)
      elseif i then return s:sub(i)
      else return ''
   end
end

--- Escaping special characters
-- @param text String
-- @return string
function M.escape(text)
  local result, _ = text:gsub('[%(%)%.%%%+%-%*%?%[%]%^%$]', '%%%0')

  return result
end

--- Removes duplicate characters in a string
-- @param text String
-- @param optional Table with references to sub and gmatch functions
-- @return string
function M.delrep(text, optional)
  local sub = optional and optional.sub or string.sub
  local gmatch = optional and optional.gmatch or string.gmatch

  local curSumbol = sub(text, 1, 1)
  local result = curSumbol

  for symbol in gmatch(text, ".") do
    if curSumbol ~= symbol then
      curSumbol = symbol
      result = result .. curSumbol
    end
  end

  return result
end

--- String split
-- @param text String
-- @param sep Separator
-- @param max Separator boundary
-- @return string
function M.split(text, sep, max)
  sep = sep or ' '

  local result = {}
  local i = 1
  for part in text:gmatch("[^"..M.escape(sep).."]+") do
    result[i] = part

    if i == max then
      break
    end

    i = i + 1
  end

  return result
end

--- String trim
-- @param text String
-- @return string
function M.trim(text)
  return text:match("^%s*(.-)%s*$")
end

--- String left trim
-- @param text String
-- @return string
function M.ltrim(text)
  return text:match("^%s*(.+)")
end

--- String right trim
-- @param text String
-- @return string
function M.rtrim(text)
  return text:match("(.-)%s*$")
end

--- Trim start and end new line
-- @param text String
-- @return string
function M.newLineTrim(text)
  return text:gsub('^\n(.*)\n$', '%1')
end

--- Adding a separator to a number 1000000 -> 1.000.000
-- @param value (number | string)
-- @param[optchain] opts (table) options
-- @param[optchain] opts.separator (string) separator
-- @return string
function M.num2sep(value, opts)
  if value == nil then
    return 'nil'
  end

  opts = opts or {}

  if value < 1000 then
    if opts.sign then
      if value >= 0 then
        return '+' .. tostring(value)
      end
    end

    return value
  end

  value = tostring(value)

  local len = #value
  if len <= 3 then
    return value
  end

  local num, minus = value:gsub('^%-', '')

  local result = ''
  local sepCount = 0
  local sep = opts.separator or '.'

  for i = len, 1, -1 do
    if sepCount == 3 then
      result = sep .. result
      sepCount = 0
    end

    result = num:sub(i, i) .. result
    sepCount = sepCount + 1
  end

  if minus >= 1 then
    return '-' .. result
  end

  if opts.sign then
    return '+' .. result
  end

  return result
end

-- luacheck: ignore loadstring

--- Lua format string
-- @param text (text)
-- @param args (table)
-- @param[optchain] opts (table) options
-- @param opts.eval (boolean) eval lua code
function M.fstring(text, args, opts)
  local eval = opts and opts.eval or false

  local res, _ = string.gsub(text, '%${([%w_]+)}', args)

  if eval then
    res, _ = res:gsub('([\n]-){{%s*(.-)%s*}}?([\n]-)', function (nl1, temp, nl2)
      local func, err = (load or loadstring)(temp)
      local res
      if err then
        return err
      end

      res = func()

      if res == nil then
        return ''
      end

      return nl1 .. res .. nl2
    end)
  end

  return res
end

--- Uppercase the First Letter in a text
-- @param text text
-- @param isUtf8 (boolean) true if string is utf8
function M.upperFirstLetter(text, isUtf8)
  if isUtf8 then
    local sub = utf8 and utf8.sub or M.utf8Sub
    return utf8.upper(sub(text, 1, 1))..sub(text, 2, -1)
  end

  return text:sub(1, 1):upper()..text:sub(2, -1)
end

--- Lowercase the First Letter in a text
-- @param text text
-- @param isUtf8 (boolean) true if string is utf8
function M.lowerFirstLetter(text, isUtf8)
  if isUtf8 then
    local sub = utf8 and utf8.sub or M.utf8Sub
    return utf8.lower(sub(text, 1, 1))..sub(text, 2, -1)
  end

  return text:sub(1, 1):lower()..text:sub(2, -1)
end

return M
