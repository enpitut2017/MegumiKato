map = null

setMap = ->
  current_latitude = 0
  current_longitude = 0

  if navigator.geolocation
    navigator.geolocation.getCurrentPosition ((pos) ->
      current_latitude = pos.coords.latitude
      current_longitude = pos.coords.longitude
      
      #center = new google.maps.LatLng(38.258595, 137.6850225)
      center = new google.maps.LatLng(current_latitude, current_longitude)
      options =
        zoom: 15
        center: center
        mapTypeId: google.maps.MapTypeId.ROADMAP

      map = new google.maps.Map(document.getElementById('map'), options)
    ), null
      
  

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

    if (json["press_zero"] < 400 or json["press_one"] < 400 or json["press_two"] < 400 or json["press_three"] < 400)
      icon = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|1E1EFF")
    else
      icon = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|FE7569")

    marker = new google.maps.Marker(
      position: new google.maps.LatLng(json["latitude"], json["longitude"])
      map: map
      icon: icon
    )


  submit: (message) ->
     @perform 'submit', message: message


