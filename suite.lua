require("unit")
local h = require("lambda")
local suite = Unit.suite("Lambda lib", {

  Unit.test("id returns whatever is passed", function()
    return (h.id(1) == 1)
  end),

  Unit.test("compose will combine two functions, left to right", function()
    local add1 = function (x) return x + 1 end
    local double = function (y) return 2 * y end
    local add1ThenDouble = h.compose(add1,double)
    return (add1ThenDouble(1) == 4)
  end),

  Unit.test("combine folds a list of functions into one, first to last", function()
    local add1 = function (x) return x + 1 end
    local double = function (y) return 2 * y end
    local sub3 = function (z) return z - 3 end
    local surprise = function(w) return w .. "!" end
    local doTheThings = h.combine({
      add1,
      double,
      sub3,
      surprise
    })
    return (doTheThings(2) == "3!")
  end)


})

Unit.report(suite)
