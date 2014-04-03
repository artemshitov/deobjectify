arrayProto = Array.prototype
strProto   = String.prototype
objProto   = Object.prototype

# Curry helper
curry = (fn) ->
  accumulator = (given) ->
    ->
      args = arrayProto.slice.call arguments, 0
      given2 = given.concat args

      if given2.length >= fn.length
        fn.apply(this, given2)
      else
        accumulator(given2)
  accumulator([])


# Composer
compose = ->
  fns = arrayProto.slice.call(arguments, 0).reverse()

  ->
    args = arrayProto.slice.call arguments, 0
    for fn in fns
      args = [fn.apply(this, args)]
    args[0]

compose2 = curry (a, b, c) -> a b c
compose3 = curry (a, b, c, d) -> a b c d
compose4 = curry (a, b, c, d, e) -> a b c d e


# Type checks

getType = (val) ->
  objProto.toString.call(val)[8..-2]

equals = curry (expected, fn, target) ->
  fn(target) == expected

isArray    = equals('Array', getType)
isFunction = equals('Function', getType)
isString   = equals('String', getType)

getProto = (val) ->
  switch getType(val)
    when 'Array' then arrayProto
    when 'String' then strProto
    when 'Object' then objProto


# Callers

call0 = curry (fn, target) -> fn.call target
call1 = curry (fn, arg, target) -> fn.call target, arg
call2 = curry (fn, arg, arg2, target) -> fn.call target, arg, arg2


# Misc helpers

increment = (x) -> x + 1
decrement = (x) -> x - 1
intoArray = (x) -> [x]


# Array functions

slice = curry (start, target) ->
  getProto(target).slice.call target, start

sliceTo = curry (start, end, target) ->
  getProto(target).slice.call target, start, end

clone = slice 0
tail = slice 1
head = sliceTo 0, 1
init = sliceTo 0, -1

pop = init
shift = tail

concat = curry (ys, xs) ->
  getProto(xs).concat.call xs, ys

every = call1 arrayProto.every
some = call1 arrayProto.some

filter = call1 arrayProto.filter
forEach = call1 arrayProto.forEach
map = call1 arrayProto.map

indexOf = curry (term, target) ->
  getProto(target).indexOf.call target, term

indexOfFrom = curry (term, from, target) ->
  getProto(target).indexOf.call target, term, from

lastindexOf = curry (term, target) ->
  getProto(target).lastindexOf.call target, term

lastindexOfFrom = curry (term, from, target) ->
  getProto(target).lastindexOf.call target, term, from


join = call1 arrayProto.join

push = curry (x, target) ->
  concat [x], target

unshift = curry (x, target) ->
  concat target, [x]

reduce = call2 arrayProto.reduce
reduce1 = call1 arrayProto.reduce

reduceRight = call2 arrayProto.reduceRight
reduceRight1 = call1 arrayProto.reduceRight

reverse = (target) -> clone(target).reverse()

sort = compose2 call0(arrayProto.sort), clone
sortFn = curry (fn, target) ->
  call1 arrayProto.sort, fn, clone(target)

toString = (target) ->
  call0 getProto(target).toString

length = (target) ->
  target.length


# String functions

charAt = call1 strProto.charAt

charCodeAt = call1 strProto.charCodeAt

search = call1 strProto.search
match = call1 strProto.match
replace = call2 strProto.replace

split = call1 strProto.split
splitLimit = call2 strProto.split

substr = call1 strProto.substr
substrFor = call2 strProto.substr

substring = call1 strProto.substring
substringTo = call2 strProto.substring

toLowerCase = call0 strProto.toLowerCase
toUpperCase = call0 strProto.toUpperCase

trim = call0 strProto.trim

# Exports

module.exports = {
  curry, compose, slice, sliceTo, clone, tail, head, init,
  concat, every, some, filter, forEach, map, indexOf, indexOfFrom,
  lastindexOf, lastindexOfFrom, join, pop, shift, push, reduce, reduce1,
  reduceRight, reduceRight1, sort, sortFn, unshift, toString, length
}
