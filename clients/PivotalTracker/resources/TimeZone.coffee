module.exports = ->
  class @PivotalTracker.Resources.TimeZone extends @Restive.Resource
    @schema 'writable', ->
      offset:     @a String
      olson_name: @a String

    @schema ->
      kind:       @a String
