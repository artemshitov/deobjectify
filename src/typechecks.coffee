exports.isArray = (val) ->
  Object.prototype.toString.call(val) is '[object Array]'

exports.isFunction = (val) ->
  typeof val is 'function'
