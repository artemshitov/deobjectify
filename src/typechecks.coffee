exports.isArray = (val) ->
  Object.prototype.toString.call(val) is '[object Array]'
