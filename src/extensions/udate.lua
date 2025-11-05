--- Date and time utilities
-- @module ule.udate

local DAY_SEC = 86400

local M = {
  day_sec = DAY_SEC
}

--- Get the Unix timestamp for the start of the given day
-- @param time (number) Unix timestamp
-- @return (number) Start of day timestamp
function M.getStartDayTime(time)
  local date = os.date('*t', time)
  date.hour = 0
  date.min = 0
  date.sec = 0

  return os.time(date)
end

--- Set hours, minutes, and seconds for a given date table
-- @param date (table) Date table (from `os.date('*t')`)
-- @param h (number) Hours
-- @param m (number) Minutes
-- @param s (number) Seconds
-- @return (number) Unix timestamp for the updated date
function M.setHours(date, h, m, s)
  date.hour = h
  date.min = m
  date.sec = s
  return os.time(date)
end

--- Get the current timezone
-- @return (number) Offset in seconds
function M.getTimezone()
  local now = os.time()
  return os.difftime(now, os.time(os.date('!*t', now)))
end

--- Conversion to ISO8601
-- @param[opt] unixtime number Unix timestamp (default: current time)
-- @return string ISO8601 formatted string (UTC)
-- @usage
-- print(M.toIso8601(os.time())) -- "2025-11-05T14:20:31Z"
function M.toIso8601(unixtime)
  unixtime = unixtime or os.time()
  return os.date('!%Y-%m-%dT%TZ', unixtime)
end

--- Convert ISO8601 string to Unix timestamp.
-- @param date (string) ISO8601 formatted datetime
-- @return (number|nil) Unix timestamp or `nil` if invalid
-- @usage
-- local ts = M.toUnix("2025-11-05T14:20:31Z")
function M.toUnix(date)
  if type(date) ~= 'string' then
    return nil
  end

  local yy, mm, dd, hh, min, sec = date:match('^(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):(%d+)Z$')
  if not yy or
    not mm or
    not dd or
    not hh or
    not min or
    not sec
  then
    return nil
  end

  return os.time({
    year = yy,
    month = mm,
    day = dd,
    hour = hh,
    min = min,
    sec = sec
  })
end

--- Get number of days passed since the given Unix timestamp.
-- @param time (number) Unix timestamp
-- @return (number) Days since `time`
-- @usage
-- print(M.time2days(os.time() - 172800)) -- 2
function M.time2days(time)
  return math.floor((os.time() - time) / DAY_SEC)
end

return M
