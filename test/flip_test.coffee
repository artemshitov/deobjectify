assert = require 'assert'
flip = require '../src/flip'

suite 'Flip', ->
  fn = null

  setup ->
    fn = (a, b, c) ->
      [a, b, c].join(' ')

  test 'flip', ->
    assert.equal 'c a b', flip(fn)('a', 'b', 'c')
