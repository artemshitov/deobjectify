assert = require 'assert'
string = require '../src/string'

suite 'string', ->
  str = null
  setup -> str = 'abc def'

  suite 'length', ->
    test 'normal', ->
      assert.strictEqual 7, string.length(str)

  suite 'charAt', ->
    test 'normal', ->
      assert.strictEqual 'c', string.charAt(2, str)
    test 'curried', ->
      assert.strictEqual 'c', string.charAt(2)(str)

  suite 'charCodeAt', ->
    test 'normal', ->
      assert.strictEqual 99, string.charCodeAt(2, str)
    test 'curried', ->
      assert.strictEqual 99, string.charCodeAt(2)(str)
