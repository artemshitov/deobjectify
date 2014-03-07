uncurry    = require './uncurry'
curry      = require './curry'
typeChecks = require './typechecks'

length = (xs) ->
  xs.length

concat = curry (ys, xs) ->
  xs.concat ys

every = curry (fn, xs) ->
  xs.every fn

filter = curry (fn, xs) ->
  xs.filter fn

forEach = curry (fn, xs) ->
  xs.forEach fn

indexOf = uncurry (x) -> (fromIndex) ->
  if typeChecks.isArray fromIndex
    xs = fromIndex
    xs.indexOf x
  else
    (xs) -> xs.indexOf x, fromIndex

join = uncurry (separator) -> (xs) ->
  xs.join separator

lastIndexOf = uncurry (x) -> (fromIndex) ->
  if typeChecks.isArray fromIndex
    xs = fromIndex
    xs.lastIndexOf x
  else
    (xs) -> xs.lastIndexOf x, fromIndex

map = curry (fn, xs) ->
  xs.map fn

pop = (xs) ->
  slice 0, length(xs) - 1, xs

push = uncurry (x) ->
  concat [x]

reduce = curry (fn, initial, xs) ->
  if initial is null
    xs.reduce fn
  else
    xs.reduce fn, initial

reduceRight = curry (fn, initial, xs) ->
  if initial is null
    xs.reduceRight fn
  else
    xs.reduceRight fn, initial

reverse = (xs) ->
  do slice(0, xs).reverse

slice = uncurry (start) -> (end) ->
  if end instanceof Array
    end.slice start
  else
    (xs) -> xs.slice start, end

shift = slice 1

some = curry (fn, xs) ->
  xs.some fn

sort = uncurry (fn) ->
  if typeChecks.isFunction fn
    (xs) -> slice(0, xs).sort fn
  else
    xs = fn
    do slice(0, xs).sort

splice = curry (index, howMany, ys, xs) ->
  ys = switch
    when typeChecks.isArray ys then ys
    when ys is null then []
    else [ys]
  xs = slice 0, xs
  Array.prototype.splice.apply xs, [index, howMany].concat(ys)
  xs

toLocaleString = (xs) ->
  if typeChecks.isArray xs
    Array.prototype.toLocaleString.call xs
  else
    Object.prototype.toLocaleString.call xs

toString = (xs) ->
  if typeChecks.isArray xs
    Array.prototype.toString.call xs
  else
    Object.prototype.toString.call xs

unshift = curry (x, xs) ->
  concat xs, [x]

module.exports = { length, concat, every, filter, forEach, indexOf, join,
  lastIndexOf, map, pop, push, reduce, reduceRight, reverse, shift, slice,
  some, sort, splice, toLocaleString, toString, unshift }
