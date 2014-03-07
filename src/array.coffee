uncurry    = require './uncurry'
curry      = require './curry'
typeChecks = require './typechecks'

array = module.exports

array.length = (xs) ->
  xs.length

array.concat = curry (ys, xs) ->
  xs.concat ys

array.every = curry (fn, xs) ->
  xs.every fn

array.filter = curry (fn, xs) ->
  xs.filter fn

array.forEach = curry (fn, xs) ->
  xs.forEach fn

array.indexOf = uncurry (x) -> (fromIndex) ->
  if typeChecks.isArray fromIndex
    xs = fromIndex
    xs.indexOf x
  else
    (xs) -> xs.indexOf x, fromIndex

array.join = uncurry (separator) -> (xs) ->
  xs.join separator

array.lastIndexOf = uncurry (x) -> (fromIndex) ->
  if typeChecks.isArray fromIndex
    xs = fromIndex
    xs.lastIndexOf x
  else
    (xs) -> xs.lastIndexOf x, fromIndex

array.map = curry (fn, xs) ->
  xs.map fn

array.pop = (xs) ->
  array.slice 0, array.length(xs) - 1, xs

array.push = uncurry (x) ->
  array.concat [x]

array.reduce = curry (fn, initial, xs) ->
  if initial is null
    xs.reduce fn
  else
    xs.reduce fn, initial

array.reduceRight = curry (fn, initial, xs) ->
  if initial is null
    xs.reduceRight fn
  else
    xs.reduceRight fn, initial

array.reverse = (xs) ->
  do array.slice(0, xs).reverse

array.slice = uncurry (start) -> (end) ->
  if end instanceof Array
    end.slice start
  else
    (xs) -> xs.slice start, end

array.shift = array.slice 1

array.some = curry (fn, xs) ->
  xs.some fn

array.sort = uncurry (fn) ->
  if typeChecks.isFunction fn
    (xs) -> array.slice(0, xs).sort fn
  else
    xs = fn
    do array.slice(0, xs).sort

array.splice = curry (index, howMany, ys, xs) ->
  ys = switch
    when typeChecks.isArray ys then ys
    when ys is null then []
    else [ys]
  xs = array.slice 0, xs
  Array.prototype.splice.apply xs, [index, howMany].concat(ys)
  xs

array.toLocaleString = (xs) ->
  if typeChecks.isArray xs
    Array.prototype.toLocaleString.call xs
  else
    Object.prototype.toLocaleString.call xs

array.toString = (xs) ->
  if typeChecks.isArray xs
    Array.prototype.toString.call xs
  else
    Object.prototype.toString.call xs

array.unshift = curry (x, xs) ->
  array.concat xs, [x]
