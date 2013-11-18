module.exports = ->
  class @Restive.Types[String] extends @Restive.Type
    type: String

    validators:
      ofLength:    '_ofLength'
      withPattern: '_withPattern'
      chosenFrom:  '_chosenFrom'

    _ofLength: (string, length) ->
      isRange =
        ~String(length).indexOf('..') or
          ~String(length).indexOf(',')

      [head, rest..., tail] = String(length).split /\.\.|,/

      if head? and tail?
        string.length >= head and
          string.length <= tail
      else if head? and isRange
        string.length >= head
      else if head?
        string.length == head
      else
        string.length <= tail

    _withPattern: (string, pattern) ->
      pattern.test string

    _chosenFrom: (string, choices) ->
      !!~choices.indexOf string
