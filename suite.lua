local h = require("lambda")
require("unit")
local suite = Unit.suite("Lambda lib", {

  Unit.test("id returns whatever is passed", function()
    return {
      Unit.equals(h.id(1), 1),
      Unit.equals(h.id(true), true),
      Unit.deepEquals(h.id({}), {}), 
      Unit.equals(h.id(""), ""),
    }
  end),

  Unit.test("compose will combine two functions, left to right", function()
    local add1 = function (x) return x + 1 end
    local double = function (y) return 2 * y end
    local add1ThenDouble = h.compose(add1,double)
    return {
      Unit.equals(add1ThenDouble(1),4)
    }
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
    return {
      Unit.equals(doTheThings(2), "3!")
    }
  end),
  Unit.test("equals is a function that binds a value and returns a new function that compares that bound value with a new value", function()
    local istrue = h.equals(true)
    local isOne = h.equals(1)
    return {
      Unit.equals(istrue(true), true),
      Unit.equals(istrue(false), false),
      Unit.equals(isOne(1), true),
      Unit.equals(isOne(0), false),
      Unit.equals(isOne(-1), false),
    }
  
  end),
  Unit.test("and works", function()
    local oldTom = {name = "Tom", age = 55}
    local youngTom = {name = "Tom", age = 20}
    local notTom = {name = "Jess", age = 20}
    local function isTom (t) 
      return t.name == "Tom"
    end
    local function isTwenty (t) 
      return t.age == 20
    end
    local isTwentyYearOldTom = h.andf(isTom, isTwenty)

    return {
      Unit.equals(isTwentyYearOldTom(youngTom),true),
      Unit.equals(isTwentyYearOldTom(oldTom),false),
      Unit.equals(isTwentyYearOldTom(notTom),false),
    }
  end)


})

Unit.report(suite)
