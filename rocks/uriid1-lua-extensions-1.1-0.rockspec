-- ule-1.1-0.rockspec
package = "uriid1-lua-extensions"
version = "1.1-0"

source = {
  url = "git+https://github.com/uriid1/uriid1-lua-extensions.git",
  tag = "v1.1"
}

description = {
  summary = "A collection of lightweight Lua extensions and utility modules",
  detailed = [[
    This package provides a set of small, focused Lua modules extending
    standard functionality: math, date/time, bit operations, path handling,
    string, tables, testing, and more.
  ]],
}

dependencies = {
  "lua >= 5.1"
}

build = {
  type = "builtin",
  modules = {
    ["ule"] = "src/init.lua",
    ["ule"..".extensions.udate"] = "src/extensions/udate.lua",
    ["ule"..".extensions.umath"] = "src/extensions/umath.lua",
    ["ule"..".extensions.utrig"] = "src/extensions/utrig.lua",
    ["ule"..".extensions.utable"] = "src/extensions/utable.lua",
    ["ule"..".extensions.ustring"] = "src/extensions/ustring.lua",
    ["ule"..".extensions.vec2"] = "src/extensions/vec2.lua",
    ["ule"..".extensions.path"] = "src/extensions/path.lua",
    ["ule"..".extensions.bit"] = "src/extensions/bit.lua",
    ["ule"..".extensions.test"] = "src/extensions/test.lua",
  }
}
