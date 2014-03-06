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

  suite 'reduce', ->
    sum = (acc, x) -> acc + x
    test 'normal', ->
      assert.strictEqual 'abc', array.reduce(sum, '', arr)
    test 'normal with null initial', ->
      assert.strictEqual 'abc', array.reduce(sum, null, arr)
    test 'curried', ->
      assert.strictEqual 'abc', array.reduce(sum)('')(arr)
    test 'curried with null initial', ->
      assert.strictEqual 'abc', array.reduce(sum)(null)(arr)

  suite 'reduceRight', ->
    sum = (acc, x) -> acc + x
    test 'normal', ->
      assert.strictEqual 'cba', array.reduceRight(sum, '', arr)
    test 'normal with null initial', ->
      assert.strictEqual 'cba', array.reduceRight(sum, null, arr)
    test 'curried', ->
      assert.strictEqual 'cba', array.reduceRight(sum)('')(arr)
    test 'curried with null initial', ->
      assert.strictEqual 'cba', array.reduceRight(sum)(null)(arr)

  suite 'reverse', ->
    test 'normal', ->
      assert.deepEqual ['c', 'b', 'a'], array.reverse(arr)
    test 'does not mutate target', ->
      array.reverse arr
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

  suite 'shift', ->
    test 'normal', ->
      assert.deepEqual ['b', 'c'], array.shift(arr)
    test 'does not mutate target', ->
      array.shift arr
      assert.deepEqual ['a', 'b', 'c'], arr

  suite 'some', ->
    isString = (val) -> typeof val is 'string'
    test 'normal', ->
      assert array.some(isString, arr)
    test 'curried', ->
      assert array.some(isString)(arr)

  suite 'sort', ->
    comparator = (a, b) -> switch
      when a < b then -1
      when a > b then 1
      else 0
    setup -> arr = ['c', 'b', 'a']
    test 'normal', ->
      assert.deepEqual ['a', 'b', 'c'], array.sort(arr)
    test 'normal with comparator', ->
      assert.deepEqual ['a', 'b', 'c'], array.sort(comparator, arr)
    test 'curried with comparator', ->
      assert.deepEqual ['a', 'b', 'c'], array.sort(comparator)(arr)
    test 'does not mutate target', ->
      array.sort arr
      assert.deepEqual ['c', 'b', 'a'], arr

  suite 'splice', ->
    test 'normal', ->
      assert.deepEqual ['a', 'd', 'c'], array.splice(1, 1, 'd', arr)
    test 'normal with array', ->
      assert.deepEqual ['a', 'd', 'e', 'c'], array.splice(1, 1, ['d', 'e'], arr)
    test 'normal with null', ->
      assert.deepEqual ['a', 'c'], array.splice(1, 1, null, arr)
    test 'curried', ->
      assert.deepEqual ['a', 'd', 'c'], array.splice(1)(1)('d')(arr)
    test 'curried with array', ->
      assert.deepEqual ['a', 'd', 'e', 'c'], array.splice(1)(1)(['d', 'e'])(arr)
    test 'curried with null', ->
      assert.deepEqual ['a', 'c'], array.splice(1)(1)(null)(arr)
    test 'does not mutate target', ->
      array.splice(1, 1, 'd', arr)
      assert.deepEqual ['a', 'b', 'c'], arr

  suite 'toLocaleString', ->
    test 'normal', ->
      assert.strictEqual 'a,b,c', array.toLocaleString(arr)

  suite 'toString', ->
    test 'normal', ->
      assert.strictEqual 'a,b,c', array.toString(arr)
