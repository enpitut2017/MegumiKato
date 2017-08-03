maker = null
map = null

setMap = ->
  center = new google.maps.LatLng(38.258595, 137.6850225)
  options =
    zoom: 5
    center: center
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById('map'), options)
  

App.bycycle = App.cable.subscriptions.create "BycycleChannel",
  connected: ->
    setMap()
    # Called when the subscription is ready for use on the server


  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log(data)
    json = $.parseJSON(data["message"])
    console.log(json)
    $("#table").append("<td>" + json["serial"] + ", " + json["latitude"] + ", " + json["longitude"] + "</td>")
    if marker is null
      marker = new google.maps.Marker(
        position: new google.maps.LatLng(position.lat, position.lng)
        map: map
      )
    else
      marker.setPosition(new google.maps.LatLng(position.lat, position.lng))


  submit: (message) ->
     @perform 'submit', message: message


