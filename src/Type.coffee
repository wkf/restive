_ = require 'lodash'

module.exports = ->
  class @Restive.Type
    constructor: (value, constraints) ->
      @value = @_parse(value)

      @validators  ||= {}
      @constraints ||= {}
      _.extend @constraints, constraints

      @validate()

    validate: ->
      @valid = true
      if @type
        unless _.type(@value) is @type
          @valid = false

      if @valid
        @valid = _.all @validators, (validator, constraint) =>
          if @constraints[constraint]?
            @[validator] @value, @constraints[constraint]
          else
            true
      @valid

    serialize: ->
      @value

    get: ->
      @value

    _parse: (value) ->
      if @type
        if _.type(value) is @type
          value
        else
          new @type(value)
      else
        value
