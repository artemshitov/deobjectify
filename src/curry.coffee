module.exports = (fn, arity) ->
  arity = arity or fn.length

  accumulator = (argsGiven) ->
    helper = ->
      args = Array.prototype.slice.call arguments, 0
      updatedArgsGiven = argsGiven.concat args

      if updatedArgsGiven.length >= arity
        return fn.apply(this, updatedArgsGiven)
      else
        return accumulator(updatedArgsGiven)

  accumulator([])
