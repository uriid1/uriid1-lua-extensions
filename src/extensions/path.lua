--- Модуль для работы с путями
-- @module ule.path
local M = {}

local SEP = package.config:sub(1, 1)

--- Возвращает поддиректорию
-- @param dir Директория
-- @param deep Уровень глубины поддиректории
function M.getSubDir(dir, deep)
  deep = deep or 1
  local sub_re = "[%w%d_]+"
  -- ^(.-)/[%w%d_]+/?$
  local re = "^(.-)"..SEP..(sub_re..SEP):rep(deep).."?$"
  return dir:match(re)
end

--- Склейка путей
-- @param path_1 Первый путь
-- @param path_2 Второй путь
function M.join(path_1, path_2)
  local path_1_sep = path_1:sub(-1, -1)
  local path_2_sep = path_2:sub(1, 1)

  local isPath1EqSep = path_1_sep == SEP
  local isPath2EqSep = path_2_sep == SEP

  if not isPath1EqSep and not isPath2EqSep then
    return path_1 .. SEP .. path_2
  end

  return path_1 .. path_2
end

return M