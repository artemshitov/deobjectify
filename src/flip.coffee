module.exports = (fn) ->
  ->
    args = Array.prototype.slice.call arguments, 0
    fn.apply this, [args.pop()].concat(args)
