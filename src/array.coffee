uncurry    = require './uncurry'
curry      = require './curry'
typeChecks = require './typechecks'

array = module.exports

arrayProto  = Array.prototype
objectProto = Object.prototype

array.length = (xs) ->
  xs.length

array.slice = uncurry (start) -> (end) ->
  if typeChecks.isArray end
    xs = end
    arrayProto.slice.call xs, start
  else
    (xs) -> arrayProto.slice.call xs, start, end

array.clone = array.slice 0

array.concat = curry (ys, xs) ->
  arrayProto.concat.call xs, ys

array.every = curry (fn, xs) ->
  arrayProto.every.call xs, fn

array.filter = curry (fn, xs) ->
  arrayProto.filter.call xs, fn

array.forEach = curry (fn, xs) ->
  arrayProto.forEach.call xs, fn

array.indexOf = uncurry (x) -> (fromIndex) ->
  if typeChecks.isArray fromIndex
    xs = fromIndex
    arrayProto.indexOf.call xs, x
  else
    (xs) -> arrayProto.indexOf.call xs, x, fromIndex

array.join = uncurry (separator) -> (xs) ->
  arrayProto.join.call xs, separator

array.lastIndexOf = uncurry (x) -> (fromIndex) ->
  if typeChecks.isArray fromIndex
    xs = fromIndex
    arrayProto.lastIndexOf.call xs, x
  else
    (xs) -> arrayProto.lastIndexOf.call xs, x, fromIndex

array.map = curry (fn, xs) ->
  arrayProto.map.call xs, fn

array.pop = (xs) ->
  array.slice 0, array.length(xs) - 1, xs

array.push = uncurry (x) ->
  array.concat [x]

array.reduce = curry (fn, initial, xs) ->
  if initial is null
    arrayProto.reduce.call xs, fn
  else
    arrayProto.reduce.call xs, fn, initial

array.reduceRight = curry (fn, initial, xs) ->
  if initial is null
    arrayProto.reduceRight.call xs, fn
  else
    arrayProto.reduceRight.call xs, fn, initial

array.reverse = (xs) ->
  arrayProto.reverse.call array.clone(xs)

array.shift = array.slice 1

array.some = curry (fn, xs) ->
  arrayProto.some.call xs, fn

array.sort = uncurry (fn) ->
  if typeChecks.isFunction fn
    (xs) -> arrayProto.sort.call array.clone(xs), fn
  else
    xs = fn
    arrayProto.sort.call array.clone(xs)

array.splice = curry (index, howMany, ys, xs) ->
  ys = switch
    when typeChecks.isArray ys then ys
    when ys is null then []
    else [ys]
  xs = array.slice 0, xs
  arrayProto.splice.apply xs, [index, howMany].concat(ys)
  xs

array.toLocaleString = (xs) ->
  if typeChecks.isArray xs
    arrayProto.toLocaleString.call xs
  else
    objectProto.toLocaleString.call xs

array.toString = (xs) ->
  if typeChecks.isArray xs
    arrayProto.toString.call xs
  else
    objectProto.toString.call xs

array.unshift = curry (x, xs) ->
  array.concat xs, [x]
