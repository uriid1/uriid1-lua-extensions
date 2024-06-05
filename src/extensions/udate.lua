---
-- Module for working with date and time.
-- @module date

local M = {}

---
-- Get start of the day
-- @param time Unix-time integer
-- @return integer
function M.getStartDayTime(time)
  local date = os.date('*t', time)
  date.hour = 0
  date.min = 0
  date.sec = 0

  return os.time(date)
end

---
-- Setting the time
-- @param date Date table
-- @param h Hours
-- @param m Minutes
-- @param s Seconds
-- @return integer
function M.setHours(date, h, m, s)
  date.hour = h
  date.min = m
  date.sec = s
  return os.time(date)
end

---
-- Get the current timezone
-- @return integer
function M.getTimezone()
  local now = os.time()
  return os.difftime(now, os.time(os.date('!*t', now)))
end

---
-- Conversion to ISO8601
-- @param unixtime Unix time
-- @return string
function M.toIso8601(unixtime)
  unixtime = unixtime or os.time()
  return os.date('!%Y-%m-%dT%TZ', unixtime)
end

---
-- Conversion ISO8601 to unixtime
-- @param date String
-- @return integer or nil
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

  return os.time({year=yy, month=mm, day=dd, hour=hh, min=min, sec=sec})
end

return M
