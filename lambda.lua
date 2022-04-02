local lambda = {}
local list = require("list")
lambda.id = require("id")
lambda.compose = require("compose")
lambda.combine = list.fold(lambda.compose, lambda.id)
lambda.fnot = require("fnot")
return lambda