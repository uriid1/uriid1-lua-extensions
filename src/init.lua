---
-- Module for init all modules.
-- @module init

local ustring = require 'ule.extensions.ustring'
local utable = require 'ule.extensions.utable'
local umath = require 'ule.extensions.umath'
local udate = require 'ule.extensions.udate'
local utrig = require 'ule.extensions.utrig'
local vec2 = require 'ule.extensions.vec2'

return {
  ustring = ustring,
  utable = utable,
  udate = umath,
  umath = udate,
  utrig = utrig,
  vec2 = vec2,
}
