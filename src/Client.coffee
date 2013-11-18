_      = require 'lodash'

client = require('rest').chain require('rest/interceptor/mime')

module.exports = ->
  Types     = @Restive.Types
  Resources = @Restive.Resources

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
        for e in (response.entity or [])
          new endpoint.list.class e
