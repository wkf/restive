_         = require 'lodash'
inflector = new (require('natural').NounInflector)

_.mixin
  type: (v) ->
    return String if typeof v == 'string' or v instanceof String
    return Number if typeof v == 'number' or v instanceof Number
    return Boolean if typeof v == 'boolean' or v instanceof Boolean
    return Function if v instanceof Function
    return Date if v instanceof Date
    return RegExp if v instanceof RegExp
    return Array if v instanceof Array
    return Object if v instanceof Object
  capitalize: (string) ->
    string.charAt(0).toUpperCase() + string.slice(1).toLowerCase()
  pluralize: (string) ->
    inflector.pluralize(inflector.singularize(string))
  singularize: (string) ->
    inflector.singularize(string)
  downcase: (string) ->
    string.toLowerCase()
  upcase: (string) ->
    string.toUpperCase()

program = require 'commander'

module.exports = ->
  (->
    class @Restive
      @Types: {}
      @Resources: {}

      program: require 'commander'

      constructor: ->
        @program.parse(process.argv)

    require('./Type').call(@)
    require('./Types').call(@)

    require('./Resource').call(@)

    require('./Endpoints').call(@)

    require('./Client').call(@)

    @Restive
  ).call({})
