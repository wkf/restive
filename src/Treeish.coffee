class Treeish
  map: ->



  walk: (ts..., fn) ->

    if _.all ts, @isLeaf
      fn.call ts..., k

    if t is 'array'

    max = _.max ts, (t) -> t.length

    while i++ < max
      fn.call (t[i] for t in ts)..., i


    t is 'object'


    _.reduce ts, (ks, t) -> _.extend ks, Object.keys(t)


    getKey = (ks, k) ->
      ks[k] = 1; ks

    getKeys = (ks, t) ->
      _.reduce Object.keys(t), addToSet, ks

    _.reduce ts, getKeys, {}




    u.reduce [{a:1}, {b:2}], ((ks, t) -> u.reduce Object.keys(t), ((ks, k) -> ks[k] = 1; ks), ks), {}


    u.map Object.keys(t), (k) -> ks[k]

    ((k,a) -> u.map Object.keys(a), ((j) -> k[j] = 1))


    ts[i]




console.log (new Treeish).map {a: [1,2,3]}, (n, k) -> n

# console.log Treeish.map t0, t1, t2, (n0, n1, n2, k) -> n0 + n1 + n2

module.exports = Treeish
