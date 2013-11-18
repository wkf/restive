module.exports = ->
  class @PivotalTracker.Types.Integer extends @Restive.Types[Number]
    validate: ->
      return no unless super
      @valid = @value % 1 is 0
