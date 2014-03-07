assert = require 'assert'

compose = require '../src/compose'
array   = require '../src/array'

suite 'compose', ->
  foo = null

  setup ->
    foo = [
      ['a', 'b'],
      ['c', 'd']
    ]

  test 'joins', ->
    assert.strictEqual 'a: b; c: d', compose(array.join('; '), array.map(array.join(': ')))(foo)
