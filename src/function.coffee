typeChecks = require './typechecks'

funcProto = Function.prototype

func = module.exports = {}

getArgs = (args) ->
  Array.prototype.slice.call args, 0

func.compose = ->
  fns = getArgs(arguments).reverse()

  ->
    args = getArgs arguments
    for fn in fns
      args = [fn.apply(this, args)]
    args[0]

func.uncurry = (fn) ->
  ->
    args = getArgs(arguments)
    resultFn = fn
    for a in args
      resultFn = resultFn a
      return resultFn if typeof resultFn != 'function'
    func.uncurry resultFn

func.curry = func.uncurry (arity) ->
  curry = (arity, fn) ->
    accumulator = (argsGiven) ->
      helper = ->
        args = getArgs(arguments)
        updatedArgsGiven = argsGiven.concat args

        if updatedArgsGiven.length >= arity
          return fn.apply(this, updatedArgsGiven)
        else
          return accumulator(updatedArgsGiven)

    accumulator([])
    
  if typeChecks.isFunction arity
    fn = arity
    curry fn.length, fn
  else
    (fn) -> curry(arity, fn)

func.length = (fn) ->
  fn.length

func.apply = func.uncurry (target) -> (args) ->
  if typeChecks.isFunction args
    fn = args
    fn.apply target
  else
    (fn) -> fn.apply target, args
