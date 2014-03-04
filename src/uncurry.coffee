uncurry = (fn) ->
  ->
    args = Array.prototype.slice.call arguments, 0
    resultFn = fn
    for a in args
      resultFn = resultFn a
      return resultFn if typeof resultFn != 'function'
    uncurry resultFn

module.exports = uncurry
