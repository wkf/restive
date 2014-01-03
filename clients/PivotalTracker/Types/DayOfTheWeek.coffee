_ = require 'lodash'

module.exports = ->
  class @PivotalTracker.Types.DayOfTheWeek extends @Restive.Types[String]
    DAYS_OF_THE_WEEK = [
      "Sunday"
      "Monday"
      "Tuesday"
      "Wednesday"
      "Thursday"
      "Friday"
      "Saturday"
    ]

    @validate: (value, constraints) ->
      super value, _.extend(chosenFrom: DAYS_OF_THE_WEEK, constraints)

