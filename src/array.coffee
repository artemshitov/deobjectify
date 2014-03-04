exports.isArray = (xs) ->
  xs.isArray()

exports.length = (xs) ->
  xs.length

exports.concat = (xs, ys) ->
  xs.concat ys

exports.every = (fn, xs) ->
  xs.every fn

exports.filter = (fn, xs) ->
  xs.filter fn

exports.forEach = (fn, xs) ->
  xs.forEach fn

exports.indexOf = (x, xs) ->
  xs.indexOf x

exports.join = (separator, xs) ->
  xs.join separator

exports.lastIndexOf = (x, xs) ->
  xs.lastIndexOf x

exports.map = (fn, xs) ->
  xs.map fn

exports.pop = (xs) ->
  xs.pop()

exports.push = (x, xs) ->
  xs.push x

exports.reduce = (fn, xs) ->
  xs.reduce fn

exports.reduceRight = (fn, xs) ->
  xs.reduceRight fn

exports.reverse = (xs) ->
  xs.reverse()

exports.shift = (xs) ->
  xs.shift()

exports.slice = (start, xs) ->
  xs.slice start

exports.some = (fn, xs) ->
  xs.some fn

exports.sort = (xs) ->
  xs.sort()

exports.splice = (start, removeNum, xs) ->
  xs.splice start, removeNum

exports.toLocaleString = (xs) ->
  xs.toLocaleString()

exports.toString = (xs) ->
  xs.toString()

exports.unshift = (x, xs) ->
  xs.unshift x
