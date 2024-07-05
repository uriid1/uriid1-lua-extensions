--- Модуль для работы с битами
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

--- Подсчет количества бит
-- @param x число
-- @return количество бит
function M.getBitsCount(x)
  if math.frexp then
    return math.max(1, select(2, math.frexp(x)))
  else
    return count_bits(x)
  end
end

--- Преобразование числа в строку двоичного представления
--- точность до 2^50
-- @param num Число
-- @param opts[optchain] Опции
-- @param opts.bits Количество бит
-- @param opts.to_array Вернет массив байтов
-- @return набор бит
-- @usage
-- local bits = tobits(255) -- '11111111'
function M.tobits(num, opts)
  assert(num > PRECISION_LIMIT == false,
    'Вышли за предел точности, допустимый предел - 2^50')

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

--- Преобразование набора битов -
--- из строкового или табличного представления в числовое.
--- Точность до 2^50
-- @param bin Число или массив байт
-- @param opts[optchain] Опции
-- @param opts.bits Количество бит
-- @param opts.from_array Преобразование массива байт
-- @return числовое представление бит
-- @usage
-- local num = tonum('11111111') -- 255
function M.tonum(bin, opts)
  local bits_len = #bin

  assert(bits_len > PRECISION_LIMIT == false,
    'Вышли за предел точности, допустимый предел - 2^50')

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

--- Получение байт из числа, точность 6 байт
-- @param num Число
-- @return массив байт
-- @usage
-- local bytes = M.getbytes(0xAAFFCCDDA1C1)
-- for i = 1, #bytes do
--   print(string.format("Байт %d: 0x%02X", i, bytes[i]))
-- end
function M.getBytes(num)
  local bytes = {}
  local byte_count = math.ceil(M.getBitsCount(num) / 8)

  for _ = 1, byte_count do
    -- Младший байт
    local byte = num % 256
    table.insert(bytes, 1, byte)

    -- Удаление младшего байт из числа
    num = math.floor(num / 256)
  end

  return bytes
end

return M
