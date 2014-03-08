func = require './function'
typechecks = require './typechecks'

curry   = func.curry
uncurry = func.uncurry

strProto = String.prototype

string = module.exports = {}

string.length = (str) ->
  str.length

string.charAt = curry (index, str) ->
  strProto.charAt.call str, index

string.charCodeAt = curry (index, str) ->
  strProto.charCodeAt.call str, index

string.concat = curry (ys, xs) ->
  strProto.concat.call xs, ys
