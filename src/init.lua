---
-- Module for init all modules.
-- @module init

local ustring = require 'ule.extensions.ustring'
local utable = require 'ule.extensions.utable'
local umath = require 'ule.extensions.umath'
local udate = require 'ule.extensions.udate'
local utrig = require 'ule.extensions.utrig'
local vec2 = require 'ule.extensions.vec2'
local path = require 'ule.extensions.path'
local bit = require 'ule.extensions.bit'
local test = require 'ule.extensions.test'

return {
  ustring = ustring,
  utable = utable,
  udate = udate,
  umath = umath,
  utrig = utrig,
  vec2 = vec2,
  path = path,
  bit = bit,
  test = test,
}
