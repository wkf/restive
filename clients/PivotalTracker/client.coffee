_ = require 'lodash'

module.exports = ->
  (->
    @Restive = require('../../src/Restive')()

    class @PivotalTracker extends @Restive
      constructor: ->
      # @TODO - implement remaining CLI commands
      # pt find project $PROJECT_NAME
      # pt find stories for $PROJECT_NAME
      # pt find epics for $PROJECT_NAME

        @client = new @constructor.Client
        @program
          .command('list')
          .description('list resources')
          .option('-f, --filter [fields]', 'filter by fields')
          .action @_list
        super

      _list: (resource, rest..., env) =>
        if resource is 'projects'
          @client.list('projects').then (projects) ->
            console.log if env.filter
              projects.get(env.filter)
            else
              projects.serialize()

    require('./Types').call(@)
    require('./Resources').call(@)

    class @PivotalTracker.Client extends @Restive.Client
      root: 'https://www.pivotaltracker.com/services/v5/'

      # @TODO - implement these methods
      # @get 'me'
      # @get 'my/work'
      # @get 'my/notifications'

      @resource 'Project'
      # @TODO - allow scoping of individual methods
      # @create requires: 'required'
      # @update 'writable'

    @PivotalTracker

  ).call({})
