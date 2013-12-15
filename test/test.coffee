require('mocha')
require('chai').should()

Restive = require('../src/restive')()

describe 'Restive.Types', ->
  describe 'Restive.Types[String]', ->
    describe 'ofLength', ->
      it 'should be valid', ->
        (new Restive.Types[String] ofLength: '3..5').validate('hello').should.be.true

      it 'should be invalid', ->
        (new Restive.Types[String] ofLength: '3..5').validate('hello world').should.be.false

    describe 'withPattern', ->
      it 'should be valid', ->
        (new Restive.Types[String] withPattern: /^hello$/).validate('hello').should.be.true

      it 'should be invalid', ->
        (new Restive.Types[String] withPattern: /^hello$/).validate('hello world').should.be.false

    describe 'chosenFrom', ->
      it 'should be valid', ->
        (new Restive.Types[String] chosenFrom: ['a', 'b', 'c']).validate('a').should.be.true

      it 'should be invalid', ->
        (new Restive.Types[String] chosenFrom: ['a', 'b', 'c']).validate('d').should.be.false

    describe 'multiple constraints', ->
      it 'should be valid', ->
        (new Restive.Types[String] ofLength: '3..5', chosenFrom: ['aaa', 'bb', 'c']).validate('aaa').should.be.true

      it 'should be invalid', ->
        (new Restive.Types[String] ofLength: '3..5', chosenFrom: ['aaa', 'bb', 'c']).validate('c').should.be.false

  describe 'Restive.Types[Number]', ->
    describe 'between', ->
      it 'should be valid', ->
        (new Restive.Types[Number] between: '-3..1000').validate(5).should.be.true

      it 'should be invalid', ->
        (new Restive.Types[Number] between: '-3..1000').validate(5000).should.be.false

  describe 'Restive.Types[Boolean]', ->
    it 'should be valid', ->
      (new Restive.Types[Boolean]).validate(false).should.be.true

    it 'should be invalid', ->
      (new Restive.Types[Boolean]).validate('hello').should.be.true
