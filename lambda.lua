local lambda = {}
local list = require("list")
lambda.id = function(i) return i end
lambda.compose = function (f1, f2)
  return function (arg)
    return f2(f1(arg))
  end
end
lambda.combine = list.fold(lambda.compose, lambda.id)
lambda.notf = function(bool) return not(bool) end
lambda.fnot = lambda.notf --so that the rename won't break old code
lambda.equals = function(val1)
  return function(val2)
    return val1 == val2
  end
end
lambda.andf = function (f1, f2)
  return function (val)
    return f1(val) and f2(val)
  end
end
return lambda