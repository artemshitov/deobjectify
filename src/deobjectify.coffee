d = deobjectify = module.exports = {}

arrayProto = Array.prototype
strProto   = String.prototype
objProto   = Object.prototype

# Curry helper
curry = (fn) ->
  accumulator = (given) ->
    (args...)->
      given2 = given.concat args

      if given2.length >= fn.length
        fn.apply(this, given2)
      else
        accumulator(given2)
  accumulator([])


# Composer
compose = (fns...) ->
  (args...) ->
    for fn in fns.reverse()
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

d.slice = curry (start, target) ->
  getProto(target).slice.call target, start

d.sliceTo = curry (start, end, target) ->
  getProto(target).slice.call target, start, end

clone = d.slice 0
tail = d.slice 1
head = d.sliceTo 0, 1
init = d.sliceTo 0, -1

d.pop = init
d.shift = tail

d.concat = curry (ys, xs) ->
  getProto(xs).concat.call xs, ys

d.every = call1 arrayProto.every
d.some = call1 arrayProto.some

d.filter = call1 arrayProto.filter
d.forEach = call1 arrayProto.forEach
d.map = call1 arrayProto.map

d.indexOf = curry (term, target) ->
  getProto(target).indexOf.call target, term

d.indexOfFrom = curry (term, from, target) ->
  getProto(target).indexOf.call target, term, from

d.lastindexOf = curry (term, target) ->
  getProto(target).lastindexOf.call target, term

d.lastindexOfFrom = curry (term, from, target) ->
  getProto(target).lastindexOf.call target, term, from


d.join = call1 arrayProto.join

d.push = curry (x, target) ->
  d.concat [x], target

d.unshift = curry (x, target) ->
  d.concat target, [x]

d.reduce = call2 arrayProto.reduce
d.reduce1 = call1 arrayProto.reduce

d.reduceRight = call2 arrayProto.reduceRight
d.reduceRight1 = call1 arrayProto.reduceRight

d.reverse = (target) -> clone(target).reverse()

d.sort = compose2 call0(arrayProto.sort), clone
d.sortFn = curry (fn, target) ->
  call1 arrayProto.sort, fn, clone(target)

d.toString = (target) ->
  call0 getProto(target).toString

d.length = (target) ->
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
