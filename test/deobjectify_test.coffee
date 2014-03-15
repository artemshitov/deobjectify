assert = require 'assert'
d      = require '../src/deobjectify'


arr = null
str = null


suite 'deobjectify', ->

  setup ->
    arr = ['a', 'b', 'c']
    str = 'abc def'
  
  suite 'slice', ->
    suite 'array', ->
      test 'normal', ->
        assert.deepEqual ['b', 'c'], d.slice(1, arr)
      test 'curried', ->
        assert.deepEqual ['b', 'c'], d.slice(1)(arr)
    suite 'string', ->
      test 'normal', ->
        assert.strictEqual 'bc def', d.slice(1, str)
      test 'curried', ->
        assert.strictEqual 'bc def', d.slice(1)(str)

  suite 'sliceTo', ->
    suite 'array', ->
      test 'normal', ->
        assert.deepEqual ['a', 'b'], d.sliceTo(0, 2, arr)
      test 'curried', ->
        assert.deepEqual ['a', 'b'], d.sliceTo(0)(2)(arr)
    suite 'string', ->
      test 'normal', ->
        assert.strictEqual 'bc', d.sliceTo(1, 3, str)
      test 'curried', ->
        assert.strictEqual 'bc', d.sliceTo(1)(3)(str)

  suite 'push', ->
    test 'normal', ->
      assert.deepEqual arr, d.push('c', ['a', 'b'])
    test 'curried', ->
      assert.deepEqual arr, d.push('c')(['a', 'b'])

  suite 'reduce', ->
    sum = (acc, x) -> acc + x
    test 'normal', ->
      assert.strictEqual 'abc', d.reduce(sum, '', arr)
    test 'curried', ->
      assert.strictEqual 'abc', d.reduce(sum)('')(arr)

  suite 'reduceRight', ->
    sum = (acc, x) -> acc + x
    test 'normal', ->
      assert.strictEqual 'cba', d.reduceRight(sum, '', arr)
    test 'curried', ->
      assert.strictEqual 'cba', d.reduceRight(sum)('')(arr)

  suite 'reduce1', ->
    sum = (acc, x) -> acc + x
    test 'normal', ->
      assert.strictEqual 'abc', d.reduce1(sum, arr)
    test 'curried', ->
      assert.strictEqual 'abc', d.reduce1(sum)(arr)

  suite 'reduceRight1', ->
    sum = (acc, x) -> acc + x
    test 'normal', ->
      assert.strictEqual 'cba', d.reduceRight1(sum, arr)
    test 'curried', ->
      assert.strictEqual 'cba', d.reduceRight1(sum)(arr)

  suite 'sort', ->
    setup -> arr = ['c', 'b', 'a']
    test 'normal', ->
      assert.deepEqual ['a', 'b', 'c'], d.sort(arr)
    test 'does not mutate target', ->
      d.sort arr
      assert.deepEqual ['c', 'b', 'a'], arr

  suite 'sortFn', ->
    comparator = (a, b) -> switch
      when a < b then -1
      when a > b then 1
      else 0
    setup -> arr = ['c', 'b', 'a']
    test 'normal', ->
      assert.deepEqual ['a', 'b', 'c'], d.sortFn(comparator, arr)
    test 'curried', ->
      assert.deepEqual ['a', 'b', 'c'], d.sortFn(comparator)(arr)
    test 'does not mutate target', ->
      d.sortFn comparator, arr
      assert.deepEqual ['c', 'b', 'a'], arr    
