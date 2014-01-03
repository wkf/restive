_ = require 'lodash'

module.exports = ->
  class @Restive.Type
    @validate: (value, constraints = {}) ->
      value = @parse(value)

      if @type
        unless _.type(value) is @type
          return false

      _.all @validators, (validator, constraint) =>
        if constraints[constraint]?
          @[validator] value, constraints[constraint]
        else
          true

    @parse: (value) ->
      if @type
        if _.type(value) is @type
          value
        else
          new @type(value)
      else
        value
