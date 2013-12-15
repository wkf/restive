_      = require 'lodash'

client = require('rest').chain require('rest/interceptor/mime')

module.exports = ->
  Types      = @Restive.Types
  Resources  = @Restive.Resources
  Collection = @Restive.Collection

  class @Restive.Client
    @resource: (resource) ->
      plural   = _(resource).downcase().pluralize().value()
      singular = _(resource).downcase().singularize().value()

      @::endpoints ||= {}
      @::endpoints[plural] =
        list:
          method: "GET"
          path: "#{plural}"
          class: Resources[resource]

    list: (resource) ->
      plural   = _(resource).downcase().pluralize().value()
      singular = _(resource).downcase().singularize().value()

      endpoint = @endpoints[plural || singular]

      request =
        method: endpoint.list.method
        path: "#{@root}#{endpoint.list.path}"
        headers:
          'X-TrackerToken': process.env.PIVOTAL_TRACKER_TOKEN

      client(request).then (response) ->
        new Collection(response.entity, endpoint.list.class)

    list: (resource, filter) ->
    create: (resource, data) ->
    view: (resource, filter) ->
    update: (resource, filter, data) ->
    delete: (resource, filter)->

  # resource names aren't globally unique, so we
  #  might need to disambiguate based on the filter

    _lookupResorce: (resource) ->


      # VERB RESOURCE[s]( for RESOURCE and RESOURCE...)

      # create story for punchpro 'as a user, I should be able to do something, '



