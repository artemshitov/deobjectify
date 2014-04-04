# Experimental direction with proper collection APIs
c = collette = module.exports


# Helpers

clone = (xs) -> xs[0..]

compose = (fns) ->
  (args...) ->
    for fn in fns
      args = [fn.apply(this, args)]
    args[0]

# Basic operations

c.head = (xs) -> xs[0]
c.last = (xs) -> xs[-1]
c.tail = (xs) -> xs[1..]
c.init = (xs) -> xs[..-1]

c.length = (xs) ->
  xs.length

c.isEmpty = (xs) ->
  c.length(xs) == 0


# Reducing lists

c.foldr = (fn, initial) -> (xs) ->
  xs.reduceRight fn, initial


# List transformations

c.concat = c.foldr ((x, acc) -> acc.concat x), []
c.flatten = c.concat

c.map = (fn) -> (xs) ->
  xs.map fn

c.concatMap = (fn) -> (xs) ->
  c.concat c.map(fn)(xs)

c.reverse = (xs) ->
  clone(xs).reverse()

c.intersperse = (sep) ->
  compose [c.init, c.concatMap((x) -> [x, sep])]

c.intercalate = ->
  compose [c.concat, c.intersperse]
