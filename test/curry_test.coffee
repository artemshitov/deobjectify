assert = require 'assert'
curry  = require '../src/curry'

fn = (a, b, c, d) ->
  [a, b, c, d].join(' ')

fnCurried = curry fn
fnCurriedExplicit = curry 3, fn

suite 'curry', ->
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
