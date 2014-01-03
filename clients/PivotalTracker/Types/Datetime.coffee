_ = require 'lodash'

module.exports = ->
  class @PivotalTracker.Types.Datetime extends @Restive.Type
    @type: Date

    @validate: (value) ->
      return no unless super
      !_.isNaN(@parse(value).getTime())

    @serialize: (v) ->
      v.toISOString()

  class @PivotalTracker.Types[Date] extends @PivotalTracker.Types.Datetime
    @serialize: (v) ->
      super.split('T')[0]
