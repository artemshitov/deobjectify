assert = require 'assert'
uncurry = require '../src/uncurry'

suite 'uncurry', ->
  fn = null
  cfn = null

  setup ->
    fn = (a) -> (b) -> (c) ->
      [a, b, c].join ' '
    cfn = uncurry fn

  test 'curried', ->
    assert.equal 'a b c', fn('a')('b')('c')

  test 'uncurry 1', ->
    assert.equal 'a b c', cfn('a', 'b')('c')

  test 'uncurry 2', ->
    assert.equal 'a b c', cfn('a', 'b', 'c')

  test 'uncurry 3', ->
    assert.equal 'a b c', cfn('a', 'b', 'c', 'd')
