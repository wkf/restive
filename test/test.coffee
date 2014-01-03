require('mocha')
require('chai').should()

Restive = require('../src/restive')()

describe 'Restive.Types', ->
  describe 'Restive.Types[String]', ->
    describe 'ofLength', ->
      it 'should be valid', ->
        Restive.Types[String].validate('hello', ofLength: '3..5').should.be.true

      it 'should be invalid', ->
        Restive.Types[String].validate('hello world', ofLength: '3..5').should.be.false

    describe 'withPattern', ->
      it 'should be valid', ->
        Restive.Types[String].validate('hello', withPattern: /^hello$/).should.be.true

      it 'should be invalid', ->
        Restive.Types[String].validate('hello world', withPattern: /^hello$/).should.be.false

    describe 'chosenFrom', ->
      it 'should be valid', ->
        Restive.Types[String].validate('a', chosenFrom: ['a', 'b', 'c']).should.be.true

      it 'should be invalid', ->
        Restive.Types[String].validate('d', chosenFrom: ['a', 'b', 'c']).should.be.false

    describe 'multiple constraints', ->
      it 'should be valid', ->
        Restive.Types[String].validate('aaa', ofLength: '3..5', chosenFrom: ['aaa', 'bb', 'c']).should.be.true

      it 'should be invalid', ->
        Restive.Types[String].validate('c', ofLength: '3..5', chosenFrom: ['aaa', 'bb', 'c']).should.be.false

  describe 'Restive.Types[Number]', ->
    describe 'between', ->
      it 'should be valid', ->
        Restive.Types[Number].validate(5, between: '-3..1000').should.be.true

      it 'should be invalid', ->
        Restive.Types[Number].validate(5000, between: '-3..1000').should.be.false

  describe 'Restive.Types[Boolean]', ->
    it 'should be valid', ->
      Restive.Types[Boolean].validate(false).should.be.true

    it 'should be invalid', ->
      Restive.Types[Boolean].validate('hello').should.be.true
