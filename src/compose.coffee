getArgs = (args) ->
  Array.prototype.slice.call args, 0

module.exports = ->
  fns = getArgs(arguments).reverse()

  ->
    args = getArgs arguments
    for fn in fns
      args = [fn.apply(this, args)]
    args[0]
