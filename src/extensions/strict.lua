--- https://www.lua.org/pil/14.2.html
--
local ENV = {}

_G.declare = function(name, initval)
  rawset(_G, name, initval)
  ENV[name] = true
end

setmetatable(_G, {
  __newindex = function (t, n, v)
    if not ENV[n] then
      error('attempt to write to undeclared var. '..n, 2)
    else
      -- do the actual set
      rawset(t, n, v)
    end
  end,

  __index = function (_, n)
    if not ENV[n] then
      error('attempt to read undeclared var. '..n, 2)
    else
      return nil
    end
  end,
})
