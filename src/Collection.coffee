_ = require 'lodash'

module.exports = ->
  PROXIED_LODASH_METHODS = [
    "forEach"
    "each"
    "map"
    "collect"
    "reduce"
    "foldl"
    "inject"
    "reduceRight"
    "foldr"
    "find"
    "detect"
    "filter"
    "select"
    "reject"
    "every"
    "all"
    "some"
    "any"
    "contains"
    "include"
    "invoke"
    "max"
    "min"
    "sortBy"
    "groupBy"
    "shuffle"
    "toArray"
    "size"
    "first"
    "head"
    "take"
    "initial"
    "rest"
    "tail"
    "last"
    "without"
    "indexOf"
    "lastIndexOf"
    "isEmpty"
    "chain"
  ]

  PROXIED_RESOURCE_METHODS = [
    "get"
    "serialize"
  ]

  class @Restive.Collection
    constructor: (array, klass) ->
      @[i] = new klass(e) for e, i in (array || [])
      @length = array?.length || 0

  _.each PROXIED_LODASH_METHODS, (m) =>
    @Restive.Collection::[m] = (args...) ->
      _[m](@, args...)

  _.each PROXIED_RESOURCE_METHODS, (m) =>
    @Restive.Collection::[m] = (args...) ->
      @map (r) -> r[m](args...)
