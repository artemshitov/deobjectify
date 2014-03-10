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

  suite 'replace', ->
    test 'normal', ->
      assert.strictEqual 'def def', string.replace('abc', 'def', str)
    test 'curried', ->
      assert.strictEqual 'def def', string.replace('abc')('def')(str)

  suite 'search', ->
    test 'normal', ->
      assert.deepEqual 1, string.search(/b/, str)
    test 'curried', ->
      assert.deepEqual 1, string.search(/b/)(str)

  suite 'slice', ->
    test 'normal', ->
      assert.deepEqual str.slice(1), string.slice(1, str)
    test 'normal end', ->
      assert.deepEqual str.slice(1, 2), string.slice(1, 2, str)
    test 'curried', ->
      assert.deepEqual str.slice(1), string.slice(1)(str)
    test 'curried end', ->
      assert.deepEqual str.slice(1, 2), string.slice(1)(2)(str)

  suite 'split', ->
    test 'normal', ->
      assert.deepEqual ['abc', 'def'], string.split(' ', str)
    test 'normal with limit', ->
      assert.deepEqual ['abc'], string.split(' ', 1, str)
    test 'normal without separator', ->
      assert.deepEqual ['abc def'], string.split(null, str)
    test 'curried', ->
      assert.deepEqual ['abc', 'def'], string.split(' ')(str)
    test 'curried with limit', ->
      assert.deepEqual ['abc'], string.split(' ')(1)(str)
    test 'curried without separator', ->
      assert.deepEqual ['abc def'], string.split(null)(str)

  suite 'substr', ->
    test 'normal', ->
      assert.strictEqual 'def', string.substr(4, str)
    test 'normal with length', ->
      assert.strictEqual 'd', string.substr(4, 1, str)
    test 'curried', ->
      assert.strictEqual 'def', string.substr(4)(str)
    test 'curried with length', ->
      assert.strictEqual 'd', string.substr(4)(1)(str)

  suite 'substring', ->
    test 'normal', ->
      assert.strictEqual 'def', string.substring(4, str)
    test 'normal with length', ->
      assert.strictEqual 'd', string.substring(4, 5, str)
    test 'curried', ->
      assert.strictEqual 'def', string.substring(4)(str)
    test 'curried with length', ->
      assert.strictEqual 'd', string.substring(4)(5)(str)

  suite 'toLocaleLowerCase', ->
    test 'normal', ->
      assert.strictEqual str, string.toLocaleLowerCase('ABC DEF')

  suite 'toLowerCase', ->
    test 'normal', ->
      assert.strictEqual str, string.toLowerCase('ABC DEF')

  suite 'toLocaleUpperCase', ->
    test 'normal', ->
      assert.strictEqual 'ABC DEF', string.toLocaleUpperCase(str)

  suite 'toUpperCase', ->
    test 'normal', ->
      assert.strictEqual 'ABC DEF', string.toUpperCase(str)

  suite 'toString', ->
    test 'normal', ->
      assert.strictEqual str, string.toString(str)
