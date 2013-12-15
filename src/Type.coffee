_ = require 'lodash'

module.exports = ->
  class @Restive.Type
    isType: true

    constructor: (constraints) ->
      @validators  ||= {}
      @constraints ||= {}
      _.extend @constraints, constraints

    validate: (value) ->
      value = @parse(value)

      if @type
        unless _.type(value) is @type
          return false

      _.all @validators, (validator, constraint) =>
        if @constraints[constraint]?
          @[validator] value, @constraints[constraint]
        else
          true

    parse: (value) ->
      if @type
        if _.type(value) is @type
          value
        else
          new @type(value)
      else
        value
