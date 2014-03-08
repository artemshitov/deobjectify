func = require './function'
typechecks = require './typechecks'

strProto = String.prototype

string = module.exports = {}

string.length = (str) ->
  str.length

