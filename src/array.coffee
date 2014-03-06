uncurry    = require './uncurry'
typechecks = require './typechecks'

exports.length = (xs) ->
  xs.length

# arr.concat(value1, value2, ..., valueN)
exports.concat = uncurry (ys) -> (xs) ->
  xs.concat ys

# arr.every(callback[, thisArg])
exports.every = uncurry (fn) -> (xs) ->
  xs.every fn

# arr.filter(callback[, thisArg])
exports.filter = uncurry (fn) -> (xs) ->
  xs.filter fn

# arr.forEach(callback[, thisArg])
exports.forEach = uncurry (fn) -> (xs) ->
  xs.forEach fn

# arr.indexOf(searchElement[, fromIndex])
exports.indexOf = uncurry (x) -> (fromIndex) ->
  if typechecks.isArray fromIndex
    xs = fromIndex
    xs.indexOf x
  else
    (xs) -> xs.indexOf x, fromIndex

# str = arr.join(separator)
exports.join = uncurry (separator) -> (xs) ->
  xs.join separator

# array.lastIndexOf(searchElement[, fromIndex])
exports.lastIndexOf = (x, xs) ->
  xs.lastIndexOf x

# arr.map(callback[, thisArg])
exports.map = (fn, xs) ->
  xs.map fn

# arr.pop()
exports.pop = (xs) ->
  xs.pop()

# arr.push(element1, ..., elementN)
exports.push = (x, xs) ->
  xs.push x

# arr.reduce(callback,[initialValue])
exports.reduce = (fn, xs) ->
  xs.reduce fn

# arr.reduceRight(callback[, initialValue])
exports.reduceRight = (fn, xs) ->
  xs.reduceRight fn

# arr.reverse()
exports.reverse = (xs) ->
  xs.reverse()

# arr.shift()
exports.shift = (xs) ->
  xs.shift()

# arr.slice(begin[, end])
exports.slice = uncurry (start) -> (end) ->
  if end instanceof Array
    end.slice start
  else
    (xs) -> xs.slice start, end

# arr.some(callback[, thisArg])
exports.some = (fn, xs) ->
  xs.some fn

# arr.sort([compareFunction])
exports.sort = (xs) ->
  xs.sort()

# array.splice(index , howMany[, element1[, ...[, elementN]]])
exports.splice = (start, removeNum, xs) ->
  xs.splice start, removeNum

# arr.toLocaleString()
exports.toLocaleString = (xs) ->
  xs.toLocaleString()

# arr.toString()
exports.toString = (xs) ->
  xs.toString()

# arr.unshift(element1, ..., elementN)
exports.unshift = (x, xs) ->
  xs.unshift x
