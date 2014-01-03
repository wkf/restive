module.exports = ->
  class @PivotalTracker.Types.Integer extends @Restive.Types[Number]
    @validate: (value) ->
      return no unless super
      value % 1 is 0
