assert = require 'assert'
array = require '../src/array'

suite 'Array', ->
  arr = null

  setup ->
    arr = ['a', 'b', 'c']

  suite 'length', ->
    test 'normal', ->
      assert.strictEqual 3, array.length(arr)

  suite 'concat', ->
    test 'normal', ->
      assert.deepEqual ['a', 'b', 'c', 'a', 'b', 'c'], array.concat(arr, arr)
    test 'curried', ->
      assert.deepEqual ['a', 'b', 'c', 'a', 'b', 'c'], array.concat(arr)(arr)

  suite 'every', ->
    isString = (val) -> typeof val is 'string'
    test 'normal', ->
      assert array.every(isString, arr)
    test 'curried', ->
      assert array.every(isString)(arr)

  suite 'filter', ->
    isA = (val) -> val is 'a'
    test 'normal', ->
      assert.deepEqual ['a'], array.filter(isA, arr)
    test 'curried', ->
      assert.deepEqual ['a'], array.filter(isA)(arr)

  suite 'forEach', ->
    ys = null
    pushToYs = (val) -> ys.push val
    setup -> ys = []
    test 'normal', ->
      array.forEach(pushToYs, arr)
      assert.deepEqual ['a', 'b', 'c'], ys
    test 'curried', ->
      array.forEach(pushToYs)(arr)
      assert.deepEqual ['a', 'b', 'c'], ys

  suite 'indexOf', ->
    test 'normal', ->
      assert.strictEqual 1, array.indexOf('b', arr)
    test 'normal fromIndex', ->
      assert.strictEqual 1, array.indexOf('b', 1, arr)
    test 'normal fromIndex nonexistent', ->
      assert.strictEqual -1, array.indexOf('b', 2, arr)
    test 'curried', ->
      assert.strictEqual 1, array.indexOf('b')(arr)
    test 'curried fromIndex', ->
      assert.strictEqual 1, array.indexOf('b')(1)(arr)
    test 'curried fromIndex nonexistent', ->
      assert.strictEqual -1, array.indexOf('b')(2)(arr)

  suite 'join', ->
    test 'normal', ->
      assert.strictEqual 'a b c', array.join(' ', arr)
    test 'curried', ->
      assert.strictEqual 'a b c', array.join(' ')(arr)

  suite 'lastIndexOf', ->
    setup ->
      arr = ['a', 'b', 'b', 'c']
    test 'normal', ->
      assert.strictEqual 2, array.lastIndexOf('b', arr)
    test 'normal fromIndex', ->
      assert.strictEqual 1, array.lastIndexOf('b', 1, arr)
    test 'normal fromIndex nonexistent', ->
      assert.strictEqual -1, array.lastIndexOf('b', 0, arr)
    test 'curried', ->
      assert.strictEqual 2, array.lastIndexOf('b')(arr)
    test 'curried fromIndex', ->
      assert.strictEqual 1, array.lastIndexOf('b')(1)(arr)
    test 'curried fromIndex nonexistent', ->
      assert.strictEqual -1, array.lastIndexOf('b')(0)(arr)

  suite 'map', ->
    toUpperCase = (str) -> do str.toUpperCase
    test 'normal', ->
      assert.deepEqual ['A', 'B', 'C'], array.map(toUpperCase, arr)
    test 'curried', ->
      assert.deepEqual ['A', 'B', 'C'], array.map(toUpperCase)(arr)

  suite 'pop', ->
    test 'normal', ->
      assert.deepEqual ['a', 'b'], array.pop(arr)
    test 'does not mutate target', ->
      array.pop arr
      assert.deepEqual ['a', 'b', 'c'], arr

  suite 'push', ->
    test 'normal', ->
      assert.deepEqual ['a', 'b', 'c', 'd'], array.push('d', arr)
    test 'curried', ->
      assert.deepEqual ['a', 'b', 'c', 'd'], array.push('d')(arr)
    test 'does not mutate target', ->
      array.push 'd', arr
      assert.deepEqual ['a', 'b', 'c'], arr

  suite 'slice', ->
    test 'normal', ->
      assert.deepEqual arr.slice(1), array.slice(1, arr)
    test 'normal end', ->
      assert.deepEqual arr.slice(1, 2), array.slice(1, 2, arr)
    test 'curried', ->
      assert.deepEqual arr.slice(1), array.slice(1)(arr)
    test 'curried end', ->
      assert.deepEqual arr.slice(1, 2), array.slice(1)(2)(arr)
