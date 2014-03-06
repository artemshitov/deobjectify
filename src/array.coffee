uncurry    = require './uncurry'
typeChecks = require './typechecks'

length = (xs) ->
  xs.length

# arr.concat(value1, value2, ..., valueN)
concat = uncurry (ys) -> (xs) ->
  xs.concat ys

# arr.every(callback[, thisArg])
every = uncurry (fn) -> (xs) ->
  xs.every fn

# arr.filter(callback[, thisArg])
filter = uncurry (fn) -> (xs) ->
  xs.filter fn

# arr.forEach(callback[, thisArg])
forEach = uncurry (fn) -> (xs) ->
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
map = uncurry (fn) -> (xs) ->
  xs.map fn

# arr.pop()
pop = (xs) ->
  slice 0, length(xs) - 1, xs

# arr.push(element1, ..., elementN)
push = uncurry (x) ->
  concat [x]

# arr.reduce(callback,[initialValue])
reduce = uncurry (fn) -> (initial) -> (xs) ->
  if initial is null
    xs.reduce fn
  else
    xs.reduce fn, initial

# arr.reduceRight(callback[, initialValue])
reduceRight = uncurry (fn) -> (initial) -> (xs) ->
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
some = uncurry (fn) -> (xs) ->
  xs.some fn

# arr.sort([compareFunction])
sort = uncurry (fn) ->
  if typeChecks.isFunction fn
    (xs) -> slice(0, xs).sort fn
  else
    xs = fn
    do slice(0, xs).sort

# array.splice(index , howMany[, element1[, ...[, elementN]]])
splice = uncurry (index) -> (howMany) -> (ys) -> (xs) ->
  ys = switch
    when typeChecks.isArray ys then ys
    when ys is null then []
    else [ys]
  xs = slice 0, xs
  Array.prototype.splice.apply xs, [index, howMany].concat(ys)
  xs

# arr.toLocaleString()
toLocaleString = (xs) ->
  do xs.toLocaleString

# arr.toString()
toString = (xs) ->
  do xs.toString

# arr.unshift(element1, ..., elementN)
unshift = (x, xs) ->
  xs.unshift x

module.exports = { length, concat, every, filter, forEach, indexOf, join,
  lastIndexOf, map, pop, push, reduce, reduceRight, reverse, shift, slice,
  some, sort, splice, toLocaleString, toString, unshift }
