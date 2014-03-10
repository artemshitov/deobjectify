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

string.slice = uncurry (start) -> (end) ->
  if typechecks.isString end
    xs = end
    strProto.slice.call xs, start
  else
    (xs) -> strProto.slice.call xs, start, end

string.split = uncurry (separator) -> (limit) ->
  if typechecks.isString limit
    str = limit
    strProto.split.call str, separator
  else
    (str) -> strProto.split.call str, separator, limit

string.substr = uncurry (start) -> (length) ->
  if typechecks.isString length
    str = length
    strProto.substr.call str, start
  else
    (str) -> strProto.substr.call str, start, length

string.substring = uncurry (start) -> (end) ->
  if typechecks.isString end
    str = end
    strProto.substring.call str, start
  else
    (str) -> strProto.substring.call str, start, end

string.toLocaleLowerCase = (str) -> strProto.toLocaleLowerCase.call str
string.toLocaleUpperCase = (str) -> strProto.toLocaleUpperCase.call str

string.toLowerCase = (str) -> strProto.toLowerCase.call str
string.toUpperCase = (str) -> strProto.toUpperCase.call str

string.toString = (str) -> strProto.toString.call str

string.trim = (str) -> do str.trim
