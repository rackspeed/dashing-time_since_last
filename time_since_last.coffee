class Dashing.TimeSinceLast extends Dashing.Widget

  ready: ->
    @last_event = moment(localStorage.getItem($(@node).data('id')+'_last_event'))
    @last_event = moment() unless @last_event
    setInterval(@startTime, 500)

  onData: (data) ->
    localStorage.setItem($(@node).data('id')+'_last_event', moment())
    @last_event = moment()
    @set('time_past', moment(@last_event).fromNow())
    $(@node).fadeOut().css('background-color', @backgroundColor).fadeIn()

  startTime: =>
    @set('time_past', moment(@last_event).fromNow())
    $(@node).css('background-color', @backgroundColor())

  backgroundColor: =>
    if ($(@node).data('green-after'))
      greenAfter = parseInt($(@node).data('green-after'))
    else
      greenAfter = 100

    diff = moment().unix() - moment(@last_event).unix()
    if (diff > greenAfter)
      "#4d9e45"
    else
      "#4d9e45"
