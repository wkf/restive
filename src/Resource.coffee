_ = require 'lodash'

module.exports = ->
  Types     = @Restive.Types
  Resources = @Restive.Resources

  class @Restive.Resource
    @schema: (tags..., builder) ->
      tags.push '*'

      schema = builder.call(new @::_SchemaDSL)

      _.map tags, (t) =>
        @::schemas    ||= {}
        @::schemas[t] ||= {}

        _.extend @::schemas[t], schema

    constructor: (attributes, constraints) ->
      @attributes = @_parse(attributes) || {}
      @validate()

    get: (name) ->
      if name
        @attributes[name].get()
      else
        @

    validate: (tag) ->
      @valid = true
      @_walk tag, @attributes, (node, attribute) =>
        if attribute?
          unless attribute.validate()
            @valid = false
      @valid

    serialize: (tag) ->
      @_walk tag, @attributes, (node, attribute) =>
        attribute.get() if attribute

    _parse: (attributes, tag) ->
      @_walk tag, attributes, (node, attribute) =>
        if attribute?
          if Types[node.type]
            new Types[node.type] attribute, node.constraints
          else if Resources[node.type]
            new Resources[node.type] attribute, node.constraints

    _walk: (tag, attributes, callback) ->
      (new @_SchemaWalker @schemas[tag || '*']).walk attributes, callback

  class @Restive.Resource::_SchemaWalker
    constructor: (schema) ->
      @schema = schema

    walk: (schema, attributes, callback) ->
      unless callback
        [schema, attributes, callback] = [@schema, schema, attributes]

      tree = {}

      for name, node of schema
        attribute = attributes?[name]

        if _.isArray(node)
          if @_isLeaf(node[0])
            if _.isArray(attribute)
              branch = attribute
                .map (a) ->
                  callback(node, a)
                .filter (a) ->
                  a?
              tree[name] = branch if branch.length
          else
            if _.isArray(attribute)
              branch = attribute
                .map (a) =>
                  @walk(node[0], a, callback)
                .filter (a) ->
                  a?
              tree[name] = branch if branch.length
        else if _.isObject(node)
          if @_isLeaf(node)
              tree[name] = branch if (branch = callback(node, attribute))?
            else
              tree[name] = branch if branch = @walk(node, attribute, callback)

      tree if _.keys(tree).length

    _isLeaf: (node) ->
      node.type and _.type(node.type) isnt Object


  class @Restive.Resource::_SchemaDSL
    _a = (type, constraints) -> {type, constraints}

    a: _a
    an: _a
