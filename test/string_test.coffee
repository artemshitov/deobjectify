assert = require 'assert'
string = require '../src/string'

suite 'string', ->
  str = null
  setup -> str = 'abc def'


  suite 'length', ->
    test 'normal', ->
      assert.strictEqual 7, string.length(str)
