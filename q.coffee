
poolRuler = (markers) -> markers.map (number) ->
  o 'span.pool-marker', ''+number


characterTitle = -> "__ meh that mehs __"



NumeneraCharacterSheet = React.createClass
  getInitialState: ->
    poolRulerMax: 30

  render: ->

#    width = 297
#    width = 594
#    height = width * 210 / 297
#    a4 =
#      width: '100%'
#      viewBox: "0 0 #{width} #{height}"


    return o '.a4', {},
      o '.head-ruler.row', poolRuler [0..29]
      o '.char-title.row', characterTitle()

      o '.main-row.row',
        o '.column-left', 'LEFT!'
        o '.column-middle', 'MIDDLE!'
        o '.column-right', 'RIGHT!'

      o '.foot-ruler.row', poolRuler [30..59]


  componentDidMount: ->
    window.sheet = this




flatten = (array, flat = []) ->
  for e in array
    if Array.isArray e then flatten e, flat
    else flat.push e

  return flat


o = (def, children...) ->

  isContent = (thing) -> thing?._isReactElement or typeof thing is 'string'

  # Tag and classes
  [tagName, classes...] = def.split?('.') or []
  tagName or= 'div'

  # Properties and children
  children = flatten children
  properties = if isContent children[0] then {} else children.shift()

  # Set className
  if classes.length
    properties.className = classes.join ' '

  # Assert
  for c, index in children when !isContent(c) then throw new Error "#{def}, #{properties.key}, #{index}"

#  console.log 'o', {tagName, properties, len: children.length}
  return React.createElement tagName, properties, children...



$ ->
  sheet = React.createElement NumeneraCharacterSheet, {}
  React.render sheet, document.getElementById('content')
