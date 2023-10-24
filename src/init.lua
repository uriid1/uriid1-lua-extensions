---
-- Module for init all modules.
-- @module init

local extension_string = require 'uriid1-lua-extensions.string'
local extension_table = require 'uriid1-lua-extensions.table'
local extension_math = require 'uriid1-lua-extensions.math'
local extension_date = require 'uriid1-lua-extensions.date'

return {
  ['string'] = extension_string,
  ['table'] = extension_table,
  ['date'] = extension_date,
  ['math'] = extension_math,
}
