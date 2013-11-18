module.exports = ->
  class @Restive.Types[Number] extends @Restive.Type
    type: Number

    validators:
      between: '_between'

    _between: (number, range) ->
      [head, rest..., tail] = String(range).split(/\.\.|,/)

      number >= head and
        number <= tail
