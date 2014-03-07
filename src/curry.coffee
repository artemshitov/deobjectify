typeChecks = require './typechecks'
uncurry    = require './uncurry'

curry = (arity, fn) ->
  accumulator = (argsGiven) ->
    helper = ->
      args = Array.prototype.slice.call arguments, 0
      updatedArgsGiven = argsGiven.concat args

      if updatedArgsGiven.length >= arity
        return fn.apply(this, updatedArgsGiven)
      else
        return accumulator(updatedArgsGiven)

  accumulator([])

module.exports = uncurry (arity) ->
  if typeChecks.isFunction arity
    fn = arity
    curry fn.length, fn
  else
    (fn) -> curry(arity, fn)
