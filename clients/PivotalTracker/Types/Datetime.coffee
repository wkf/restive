_ = require 'lodash'

module.exports = ->
  class @PivotalTracker.Types.Datetime extends @Restive.Type
    type: Date

    validate: ->
      return no unless super
      @valid = !_.isNaN(@value.getTime())

    serialize: (v) ->
      v.toISOString()

  class @PivotalTracker.Types[Date] extends @PivotalTracker.Types.Datetime
    serialize: (v) ->
      super.split('T')[0]
