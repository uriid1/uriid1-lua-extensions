package.path = package.path .. ';.rocks/share/lua/5.1/?.lua'
package.path = package.path .. ';.rocks/share/lua/5.1/?/init.lua'
package.path = package.path .. ';src/extensions/?.lua'

require('test.test_vec2')
require('test.test_utable')

local lu = require('luaunit')
os.exit(lu.run())
