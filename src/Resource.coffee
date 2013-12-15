_ = require 'lodash'

module.exports = ->
  Types     = @Restive.Types
  Resources = @Restive.Resources

  class @Restive.Resource
    @schema: (tags..., builder) ->
      @::schemas ||= {}
      (@::schema ||= new @::Schema).extend (schema = new @::Schema builder)
      _.map tags, (t) =>
        (@::schemas[t] ||= new @::Schema).extend schema

    isResource: true

    validate: (attributes, tags...) ->
      @_schemaForTags(tags).all attributes, (node, attribute) ->
        node.validate(attribute)

    parse: (attributes, tags...) ->
      @_schemaForTags(tags).walk attributes, (node, attribute) ->
        node.parse(attribute)

    _schemaForTags: (tags) ->
      if tags?.length
        schema = new @Schema
        _.map tags, (t) =>
          schema.extend @schemas[t]
        schema
      else
        @schema

  class @Restive.Resource::Schema
    constructor: (builder) ->
      @root = (new @Builder @_result(builder)).map (node) ->
        if Types[node.type]
          new Types[node.type] node.constraints
        else
          new Resources[node.type] node.constraints

    walk: (attributes, callback) ->
      (new @Walker @root).walk attributes, callback

    all: (attributes, callback) ->
      (new @Walker @root).reduce attributes, (node, attribute, memo) ->
        memo and callback(node, attribute)

    extend: (schema) ->
      _.extend(@root, schema.root)

    _result: (builder) ->
      if _.isFunction(builder)
        builder.call(new @DSL)
      else
        builder

  class Tree extends EventEmitter
    constructor: (root) ->
      @root = root

    map: () ->
    reduce: () ->
    merge: () ->
    walk: () ->

  class Tree::Node
    isLeaf: ->
      @

  schema.on 'node:visit', ->
  schema.on 'node:enter', ->
  schema.on 'node:leave', ->

  class @Restive.Resource::Schema::Walker
    constructor: (root) ->
      @root = root

    _walk: (node, attributes, isLeaf, onLeaf) ->
      @_visit node, attributes, isLeaf, onLeaf

    _visit: (node, attributes, isLeaf, onLeaf) ->
      if isLeaf(node)
        onLeaf(node, attributes)
      else if _.isArray(node)
        @_walkArray(node, attributes, isLeaf, onLeaf)
      else if _.isObject(node)
        @_walkObject(node, attributes, isLeaf, onLeaf)

    _walkObject: (nodes, attributes, isLeaf, onLeaf) ->
      tree = {}

      for name, node of nodes
        if (branch = @_visit node, attributes?[name], isLeaf, onLeaf)?
          tree[name] = branch

      console.log tree
      tree if _.keys(tree).length

    _walkArray: (nodes, attributes, isLeaf, onLeaf) ->
      branch = if isLeaf(nodes[0])
        if _.isArray(attribute)
          attribute.map (a) -> onLeaf(nodes[0], a)
        else
          [onLeaf(nodes[0])]
      else
        if _.isArray(attributes)
          attribute.map (a) => @_visit(nodes[0], a, isLeaf, onLeaf)
        else
          [@_visit(nodes[0], null, isLeaf, onLeaf)]

      branch if (branch = branch.filter (a) -> a?).length

    isLeaf: (node) ->
      node?.isType is true or node?.isResource is true

  class @Restive.Resource::Schema::Builder extends @Restive.Resource::Schema::Walker
    isLeaf: (node) ->
      node.type and _.type(node.type) isnt Object

  class @Restive.Resource::Schema::DSL
    _a = (type, constraints) -> {type, constraints}

    a: _a
    an: _a
