require('mocha-as-promised')(require('mocha'))
require('chai').should()
require('chai').use(require('chai-as-promised'))

PivotalTracker = require('../client')()

describe 'PivotalTracker.Types', ->
  describe 'PivotalTracker.Types[Date]', ->
    it 'should be valid', ->
      (new PivotalTracker.Types[Date] '2013-04-30').valid.should.be.true
    it 'should be valid when given a date', ->
      (new PivotalTracker.Types[Date] new Date('2013-04-30')).valid.should.be.true
    it 'should be invalid when bad date', ->
      (new PivotalTracker.Types[Date] '2013-84-30').valid.should.be.false

  describe 'PivotalTracker.Types.DayOfTheWeek', ->
    it 'should be valid', ->
      (new PivotalTracker.Types.DayOfTheWeek 'Wednesday').valid.should.be.true
    it 'should be invalid', ->
      (new PivotalTracker.Types.DayOfTheWeek 'October').valid.should.be.false

  describe 'PivotalTracker.Types.Integer', ->
    it 'should be valid', ->
      (new PivotalTracker.Types.Integer 1000).valid.should.be.true
    it 'should be invalid', ->
      (new PivotalTracker.Types.Integer 1.25).valid.should.be.false

describe 'PivotalTracker.Resources', ->
  describe 'PivotalTracker.Resources.TimeZone', ->
    it 'should be valid', ->
      (new PivotalTracker.Resources.TimeZone offset: 'Eastern').valid.should.be.true
    it 'should be invalid', ->
      (new PivotalTracker.Resources.TimeZone offset: 1).valid.should.be.true

  describe 'PivotalTracker.Resources.Project', ->
    validProject =
      id: 1
      name: 'A big project'
      time_zone:
        offset: 'Eastern'

    invalidProject =
      name: 123
      start_date: 'hello'

    it 'should be valid', ->
      (new PivotalTracker.Resources.Project validProject).valid.should.be.true

    it 'should be invalid', ->
      (new PivotalTracker.Resources.Project invalidProject).valid.should.be.false

describe 'PivotalTracker.Client', ->
  it 'should be able to get a list of projects', ->
    (new PivotalTracker.Client).list('projects').should.eventually.be.an('array')
