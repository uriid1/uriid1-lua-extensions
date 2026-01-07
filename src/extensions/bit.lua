--- Bitwise utilities module
-- @module ule.bit
local M = {}

local PRECISION_LIMIT = 2^50

local function count_bits(x)
  local count = 0
  while x > 0 do
    x = math.floor(x / 2)
    count = count + 1
  end
  return count
end

--- Get number of bits required to represent a number
-- @param x (number) Input value
-- @return (number) Bit count
function M.getBitsCount(x)
  if math.frexp then
    return math.max(1, select(2, math.frexp(x)))
  else
    return count_bits(x)
  end
end

--- Convert a number to its binary representation
-- Precision limited to 2^50
-- @param num number Input value
-- @param[optchain] opts table Options
-- @param[opt] opts.bits number Force output bit width
-- @param[opt] opts.to_array boolean Return bit array instead of string
-- @return string|table Binary representation as string or array
-- @usage
-- local bits = M.tobits(255) -- "11111111"
function M.tobits(num, opts)
  assert(num > PRECISION_LIMIT == false,
    'Exceeded precision limit, maximum allowed is 2^50')

  local bits
  if opts and opts.bits then
    bits = opts.bits
  else
    bits = M.getBitsCount(num)
  end

  local data_bits = {}
  for bit = bits, 1, -1 do
    data_bits[bit] = math.fmod(num, 2)
    num = math.floor((num - data_bits[bit]) / 2)
  end

  if opts and opts.to_array then
    return data_bits
  end

  return table.concat(data_bits)
end

--- Convert a binary sequence (string or array) to a number
-- Precision limited to 2^50
-- @param bin string|table Binary data
-- @param[optchain] opts table Options
-- @param[opt] opts.bits number Bit length
-- @param[opt] opts.from_array boolean Interpret input as bit array
-- @return number Decimal value
-- @usage
-- local num = M.tonum("11111111") -- 255
function M.tonum(bin, opts)
  local bits_len = #bin

  assert(bits_len > PRECISION_LIMIT == false,
    'Exceeded precision limit, maximum allowed is 2^50')

  if opts and opts.from_array then
    local sum = 0
    for i = bits_len, 1, -1 do
      sum = sum + bin[i] * 2^(bits_len - i)
    end
    return math.floor(sum)
  end

  local sum = 0
  for i = bits_len, 1, -1 do
    local num = tonumber(bin:sub(i, i))
    sum = sum + num * 2^(bits_len - i)
  end
  return math.floor(sum)
end

--- Extract bytes from a number
-- Precision: up to 6 bytes (48 bits)
-- @param num number Input value
-- @return table Array of bytes (most significant first)
-- @usage
-- local bytes = M.getBytes(0xAAFFCCDDA1C1)
-- for i = 1, #bytes do
--   print(string.format("Byte %d: 0x%02X", i, bytes[i]))
-- end
function M.getBytes(num)
  local bytes = {}
  local byte_count = math.ceil(M.getBitsCount(num) / 8)

  for _ = 1, byte_count do
    local byte = num % 256
    table.insert(bytes, 1, byte)
    num = math.floor(num / 256)
  end

  return bytes
end

return M
