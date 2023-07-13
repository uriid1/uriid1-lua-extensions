--[[
  ####--------------------------------####
  #--# Author:   by uriid1            #--#
  #--# License:  GNU GPLv3            #--#
  #--# Telegram: @main_moderator      #--#
  #--# E-mail:   appdurov@gmail.com   #--#
  ####--------------------------------####
--]]

local _D2R = math.pi / -180
local _R2D = -180 / math.pi

-- Комбинаторика
--

--Факториал / Перестановка (1 * ... * n)
--Для подсчета кол-во вариантов перестановки например
--@param n? Number
--@return number 
local function factorial(n)
  local res = 1
  for i = 1, n do
    res = i * res
  end

  return res
end

--Размешение
--Выборка из n по k элементов с учётом порядка
--Или формула для подсчёта кол-во размещений без повторений
--@param n? Number
--@param k? Number
--@return number 
local function placement(n, k)
  return factorial(n) / factorial(n - k)
end

--Сочетание
--Выборка без учета порядка
--@param n? Number
--@param k? Number
--@return number 
local function combination(n, k)
  return factorial(n) / (factorial(n - k) * factorial(k))
end

-- Math
--

local function sign(x)
  return (x > 0) and 1 or (x == 0 and 0 or -1)
end

local function round(x)
  return (x >= 0) and math.floor(x + 0.5) or math.ceil(x - 0.5)
end

local function clamp(val, val_min, val_max)
  return math.max(val_min, math.min(val_max, val))
end

local function lerp(v0, v1, t)
  return v0 * (1.0 - t) + t * v1
end

-- Trig
--

local function lengthdirX(length, direction)
  return length * math.cos(direction * _D2R)
end

local function lengthdirY(length, direction)
  return length * math.sin(direction * _D2R)
end

local function pointDirection(x1, y1, x2, y2)
  return (_R2D * (math.atan2(y1 - y2, x1 - x2))) + 180
end

local function angleDifference(ang1, ang2)
  return ((((ang1 - ang2) % 360) + 540) % 360) - 180
end

local function distance2point(x1, y1, x2, y2) 
  return math.sqrt( (x1 - x2)^2 + (y1 - y2)^2 )
end

local function deg2rad(degree)
  return degree * _D2R
end

local function rad2deg(degree)
  return degree * _R2D
end

return {
  factorial = factorial;
  placement = placement;
  combination = combination;

  sign = sign;
  round = round;
  clamp = clamp;
  lerp = lerp;

  lengthdirX = lengthdirX;
  lengthdirY = lengthdirY;
  pointDirection = pointDirection;
  angleDifference = angleDifference;
  distance2point = distance2point;
  deg2rad = deg2rad;
  rad2deg = rad2deg;
}
