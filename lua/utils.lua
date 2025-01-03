local function inc(x, _3fy)
  return (x + (_3fy or 1))
end
local function dec(x, _3fy)
  return (x - (_3fy or 1))
end
local function first(seq)
  local t_1_ = seq
  if (nil ~= t_1_) then
    t_1_ = t_1_[1]
  else
  end
  return t_1_
end
local function last(seq)
  local t_3_ = seq
  if (nil ~= t_3_) then
    t_3_ = t_3_[#seq]
  else
  end
  return t_3_
end
local function nil_3f(x)
  return (x == nil)
end
local function table_3f(x)
  return (type(x) == "table")
end
return {inc = inc, dec = dec, first = first, last = last, ["nil?"] = nil_3f, ["table?"] = table_3f}
