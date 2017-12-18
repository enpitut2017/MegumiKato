map = null

setDOM = (data) ->
  status = $.parseJSON(data["bicycle"])["status"]

  """
  <div class="card" style="width: 20rem;">
    <img class="card-img-top" src="http://via.placeholder.com/350x150" alt="">
    <div class="card-block">
      <h4 class="card-title">#{data["serial"]}</h4>
      <ul class="list-group list-group-flush">
        <li class="list-group-item">#{data["latitude"]}, #{data["longitude"]}</li>
        <li class="list-group-item">#{if status then "警戒中" else "非警戒中"}</li>
      </ul>
      <p class="card-text"><small class="text-muted">#{data["created_at"]}</small></p>
    </div>
  </div>
  """

setInfoWindow = (data) ->
  option =
    position: new google.maps.LatLng(data["latitude"], data["longitude"])
    content: setDOM(data)

  window = new google.maps.InfoWindow(option)
  window.open(map)

setLoadingAnim = ->
  $("#loading").show()
  $("#background").addClass("loading-background")

removeLoadingAnim = ->
  $('#loading').addClass("loading-slide")
  $("#background").addClass("loading-slide")

setMap = ->
  if navigator.geolocation
    setLoadingAnim()
    navigator.geolocation.getCurrentPosition ((pos) ->
      removeLoadingAnim()
      center = new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude)
      option =
        zoom: 15
        center: center

      map.setOptions(option)
    ), null

  center = new google.maps.LatLng(35.6691074,139.6012987)
  options =
    zoom: 7
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


    if (json["press_zero"] < 400 or json["press_one"] < 400 or json["press_two"] < 400 or json["press_three"] < 400)
      icon = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|1E1EFF")
    else
      icon = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|FE7569")

    marker = new google.maps.Marker(
      position: new google.maps.LatLng(json["latitude"], json["longitude"])
      map: map
      icon: icon
    )

    google.maps.event.addListener(marker, "click", (event) ->
      setInfoWindow(json)
    )



  submit: (message) ->
     @perform 'submit', message: message
