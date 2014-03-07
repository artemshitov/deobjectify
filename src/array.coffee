uncurry    = require './uncurry'
curry      = require './curry'
typeChecks = require './typechecks'

length = (xs) ->
  xs.length

# arr.concat(value1, value2, ..., valueN)
concat = curry (ys, xs) ->
  xs.concat ys

# arr.every(callback[, thisArg])
every = curry (fn, xs) ->
  xs.every fn

# arr.filter(callback[, thisArg])
filter = curry (fn, xs) ->
  xs.filter fn

# arr.forEach(callback[, thisArg])
forEach = curry (fn, xs) ->
  xs.forEach fn

# arr.indexOf(searchElement[, fromIndex])
indexOf = uncurry (x) -> (fromIndex) ->
  if typeChecks.isArray fromIndex
    xs = fromIndex
    xs.indexOf x
  else
    (xs) -> xs.indexOf x, fromIndex

# str = arr.join(separator)
join = uncurry (separator) -> (xs) ->
  xs.join separator

# array.lastIndexOf(searchElement[, fromIndex])
lastIndexOf = uncurry (x) -> (fromIndex) ->
  if typeChecks.isArray fromIndex
    xs = fromIndex
    xs.lastIndexOf x
  else
    (xs) -> xs.lastIndexOf x, fromIndex

# arr.map(callback[, thisArg])
map = curry (fn, xs) ->
  xs.map fn

# arr.pop()
pop = (xs) ->
  slice 0, length(xs) - 1, xs

# arr.push(element1, ..., elementN)
push = uncurry (x) ->
  concat [x]

# arr.reduce(callback,[initialValue])
reduce = curry (fn, initial, xs) ->
  if initial is null
    xs.reduce fn
  else
    xs.reduce fn, initial

# arr.reduceRight(callback[, initialValue])
reduceRight = curry (fn, initial, xs) ->
  if initial is null
    xs.reduceRight fn
  else
    xs.reduceRight fn, initial

# arr.reverse()
reverse = (xs) ->
  do slice(0, xs).reverse

# arr.slice(begin[, end])
slice = uncurry (start) -> (end) ->
  if end instanceof Array
    end.slice start
  else
    (xs) -> xs.slice start, end

# arr.shift()
shift = slice 1

# arr.some(callback[, thisArg])
some = curry (fn, xs) ->
  xs.some fn

# arr.sort([compareFunction])
sort = uncurry (fn) ->
  if typeChecks.isFunction fn
    (xs) -> slice(0, xs).sort fn
  else
    xs = fn
    do slice(0, xs).sort

# array.splice(index , howMany[, element1[, ...[, elementN]]])
splice = curry (index, howMany, ys, xs) ->
  ys = switch
    when typeChecks.isArray ys then ys
    when ys is null then []
    else [ys]
  xs = slice 0, xs
  Array.prototype.splice.apply xs, [index, howMany].concat(ys)
  xs

# arr.toLocaleString()
toLocaleString = (xs) ->
  if typeChecks.isArray xs
    Array.prototype.toLocaleString.call xs
  else
    Object.prototype.toLocaleString.call xs

# arr.toString()
toString = (xs) ->
  if typeChecks.isArray xs
    Array.prototype.toString.call xs
  else
    Object.prototype.toString.call xs

# arr.unshift(element1, ..., elementN)
unshift = curry (x, xs) ->
  concat xs, [x]

module.exports = { length, concat, every, filter, forEach, indexOf, join,
  lastIndexOf, map, pop, push, reduce, reduceRight, reverse, shift, slice,
  some, sort, splice, toLocaleString, toString, unshift }
