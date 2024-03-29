---
-- Module for init all modules.
-- @module init

local ustring = require 'ule.extensions.ustring'
local utable = require 'ule.extensions.utable'
local umath = require 'ule.extensions.umath'
local udate = require 'ule.extensions.udate'

return {
  ustring = ustring,
  utable = utable,
  udate = umath,
  umath = udate,
}
