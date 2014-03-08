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

  suite 'concat', ->
    test 'normal', ->
      assert.strictEqual str, string.concat('def', 'abc ')
    test 'curried', ->
      assert.strictEqual str, string.concat('def')('abc ')

  suite 'indexOf', ->
    test 'normal', ->
      assert.strictEqual 1, string.indexOf('b', str)
    test 'normal fromIndex', ->
      assert.strictEqual 1, string.indexOf('b', 1, str)
    test 'normal fromIndex nonexistent', ->
      assert.strictEqual -1, string.indexOf('b', 2, str)
    test 'curried', ->
      assert.strictEqual 1, string.indexOf('b')(str)
    test 'curried fromIndex', ->
      assert.strictEqual 1, string.indexOf('b')(1)(str)
    test 'curried fromIndex nonexistent', ->
      assert.strictEqual -1, string.indexOf('b')(2)(str)

  suite 'lastIndexOf', ->
    setup ->
      arr = ['a', 'b', 'b', 'c']
    test 'normal', ->
      assert.strictEqual 1, string.lastIndexOf('b', str)
    test 'normal fromIndex', ->
      assert.strictEqual 1, string.lastIndexOf('b', 1, str)
    test 'normal fromIndex nonexistent', ->
      assert.strictEqual -1, string.lastIndexOf('b', 0, str)
    test 'curried', ->
      assert.strictEqual 1, string.lastIndexOf('b')(str)
    test 'curried fromIndex', ->
      assert.strictEqual 1, string.lastIndexOf('b')(1)(str)
    test 'curried fromIndex nonexistent', ->
      assert.strictEqual -1, string.lastIndexOf('b')(0)(str)

  suite 'match', ->
    test 'normal', ->
      assert.deepEqual 'b', string.match(/b/, str)[0]
    test 'curried', ->
      assert.deepEqual 'b', string.match(/b/)(str)[0]
