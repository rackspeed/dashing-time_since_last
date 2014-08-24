class Dashing.TimeSinceLast extends Dashing.Widget

  ready: ->
    @last_event = moment(new Date(localStorage.getItem(@get('id')+'_last_event')))
    @last_event = moment().format() unless @last_event
    setInterval(@startTime, 500)

  onData: (data) ->
    if(@get('since-date'))
      localStorage.setItem(@get('id')+'_last_event', moment(new Date(@get('since-date'))).format())

    @last_event = moment(new Date(localStorage.getItem(@get('id')+'_last_event')))

    @set('time_past', moment(@last_event).fromNow())
    $(@node).fadeOut().css('background-color', @backgroundColor).fadeIn()

  startTime: =>
    @set('time_past', moment(@last_event).fromNow())
    $(@node).css('background-color', @backgroundColor())

  backgroundColor: =>
    if (@get('green-after'))
      greenAfter = parseInt(@get('green-after'))
    else
      greenAfter = 100

    diff = moment().unix() - moment(@last_event).unix()
    if (diff > greenAfter)
      "#4d9e45"
    else
      '#e84916'
