require('mocha')
require('chai').should()

Restive = require('../src/restive')()

describe 'Restive.Types', ->
  describe 'Restive.Types[String]', ->
    describe 'ofLength', ->
      it 'should be valid', ->
        (new Restive.Types[String] 'hello', ofLength: '3..5').valid.should.be.true

      it 'should be invalid', ->
        (new Restive.Types[String] 'hello world', ofLength: '3..5').valid.should.be.false

    describe 'withPattern', ->
      it 'should be valid', ->
        (new Restive.Types[String] 'hello', withPattern: /^hello$/).valid.should.be.true

      it 'should be invalid', ->
        (new Restive.Types[String] 'hello world', withPattern: /^hello$/).valid.should.be.false

    describe 'chosenFrom', ->
      it 'should be valid', ->
        (new Restive.Types[String] 'a', chosenFrom: ['a', 'b', 'c']).valid.should.be.true

      it 'should be invalid', ->
        (new Restive.Types[String] 'd', chosenFrom: ['a', 'b', 'c']).valid.should.be.false

    describe 'multiple constraints', ->
      it 'should be valid', ->
        (new Restive.Types[String] 'aaa', ofLength: '3..5', chosenFrom: ['aaa', 'bb', 'c']).valid.should.be.true

      it 'should be invalid', ->
        (new Restive.Types[String] 'c', ofLength: '3..5', chosenFrom: ['aaa', 'bb', 'c']).valid.should.be.false

  describe 'Restive.Types[Number]', ->
    describe 'between', ->
      it 'should be valid', ->
        (new Restive.Types[Number] 5, between: '-3..1000').valid.should.be.true

      it 'should be invalid', ->
        (new Restive.Types[Number] 5000, between: '-3..1000').valid.should.be.false

  describe 'Restive.Types[Boolean]', ->
    it 'should be valid', ->
      (new Restive.Types[Boolean] false).valid.should.be.true

    it 'should be invalid', ->
      (new Restive.Types[Boolean] 'hello').valid.should.be.true
