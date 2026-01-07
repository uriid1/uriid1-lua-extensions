# (ule) uriid1-lua-extensions

A collection of lightweight **Lua utility modules**, extending the standard library with practical helpers for math, bitwise operations, date/time, paths, tables, strings, vectors, and more.  
Designed for clean, minimal code and compatibility with **Lua 5.1+**.

---

## Installation

Via **LuaRocks**:

```bash
luarocks install uriid1-lua-extensions
```

# Usage
```lua
local ule = require('ule')

local ustring = ule.ustring
local utable = ule.utable
local umath = ule.umath
local utrig = ule.utrig
local udate = ule.udate
local vec2 = ule.vec2
local path = ule.path
local bit = ule.bit
local test = ule.test
```

# Gen LDOC
```bash
ldoc -s '!new' -d ldoc src/extensions
```

# Run tests
```bash
# Install luaunit
bash ule.post-install.sh
# Run all tests (lua5.1, luajit only)
lua -lluacov test/run_all_tests.lua
```
