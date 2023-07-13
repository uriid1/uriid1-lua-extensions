--[[
  ####--------------------------------####
  #--# Author:   by uriid1            #--#
  #--# License:  GNU GPLv3            #--#
  #--# Telegram: @main_moderator      #--#
  #--# E-mail:   appdurov@gmail.com   #--#
  ####--------------------------------####
--]]

--Removes duplicate characters in a string
--@param text? String
--@param optional? Table with references to sub and gmatch functions
--@return string
local function delrep(text, optional)
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

--String split
--@param text? String
--@param sep? Separator
--@param max? Separator boundary
--@return string
local function split(text, sep, max)
  local result = {}
  local i = 1

  for part in text:gmatch("[^"..sep.."]+") do
    result[i] = part

    if i == max then
        break
    end

    i = i + 1
  end

  return result
end

--String trim
--@param text? String
--@return string
local function trim(text)
  return text:match("^%s*(.-)%s*$")
end

--Escaping special characters
--@param text? String
--@return string
local function escape(text)
  local result, _ = text:gsub('[%(%)%.%%%+%-%*%?%[%]%^%$]', '%%%0')
  return result
end

--Adding a separator to a number
--@param num? Number
--@param sep? Separator
--@return string
local function num2sep(num, sep)
  num = tostring(num)
  sep = sep or '.'

  local len = #num
  if len <= 3 then
    return num
  end

  local num, minus = num:gsub('^%-', '')

  local result = ''
  local sepCount = 0

  for i = len, 1, -1 do
    if sepCount == 3 then
      result = sep .. result
      sepCount = 0
    end

    result = num:sub(i, i) .. result
    sepCount = sepCount + 1
  end

  return (minus >= 1 and '-' or '')..result
end

return {
  delrep = delrep;
  split = split;
  trim = trim;
  escape = escape;
  num2sep = num2sep;
}
