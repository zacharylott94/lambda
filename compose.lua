return function (f1, f2)
  return function (arg)
    return f2(f1(arg))
  end
end