assert = require 'assert'
func   = require '../src/function'
array  = require '../src/array'

suite 'uncurry', ->
  fn = null
  cfn = null
  setup ->
    fn = (a) -> (b) -> (c) ->
      [a, b, c].join ' '
    cfn = func.uncurry fn
  test 'curried', ->
    assert.equal 'a b c', fn('a')('b')('c')
  test 'uncurry 1', ->
    assert.equal 'a b c', cfn('a', 'b')('c')
  test 'uncurry 2', ->
    assert.equal 'a b c', cfn('a', 'b', 'c')
  test 'uncurry 3', ->
    assert.equal 'a b c', cfn('a', 'b', 'c', 'd')

suite 'curry', ->
  fn = (a, b, c, d) ->
    [a, b, c, d].join(' ')
  fnCurried = func.curry fn
  fnCurriedExplicit = func.curry 3, fn

  test '1', ->
    assert.strictEqual 'a b c d', fnCurried('a')('b', 'c', 'd')
  test '2', ->
    assert.strictEqual 'a b c d', fnCurried('a')('b')('c', 'd')
  test '3', ->
    assert.strictEqual 'a b c d', fnCurried('a')('b')('c')('d')
  test 'pairs', ->
    assert.strictEqual 'a b c d', fnCurried('a', 'b')('c', 'd')
  test 'explicit arity', ->
    assert.strictEqual 'a b c ', fnCurriedExplicit('a')('b')('c')

suite 'compose', ->
  foo = null
  setup ->
    foo = [
      ['a', 'b'],
      ['c', 'd']
    ]
  test 'joins', ->
    assert.strictEqual 'a: b; c: d', func.compose(array.join('; '), array.map(array.join(': ')))(foo)
