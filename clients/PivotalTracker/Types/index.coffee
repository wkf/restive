module.exports = ->
  v.call(@) for n, v of require('indx')(__dirname)
