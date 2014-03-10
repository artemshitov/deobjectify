func = require './function'
array = require './array'
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

string.indexOf = uncurry (x) -> (fromIndex) ->
  if typechecks.isString fromIndex
    xs = fromIndex
    strProto.indexOf.call xs, x
  else
    (xs) -> strProto.indexOf.call xs, x, fromIndex

string.lastIndexOf = uncurry (x) -> (fromIndex) ->
  if typechecks.isString fromIndex
    xs = fromIndex
    strProto.lastIndexOf.call xs, x
  else
    (xs) -> strProto.lastIndexOf.call xs, x, fromIndex

string.match = curry (regexp, str) ->
  strProto.match.call str, regexp

string.replace = curry (what, withWhat, str) ->
  strProto.replace.call str, what, withWhat

string.search = curry (regexp, str) ->
  strProto.search.call str, regexp
