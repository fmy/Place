# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class GoogleMap
  constructor: ->
    @position = new google.maps.LatLng 20.7, 139.7
    map_options =
      center: @position
      zoom: 15
      mapTypeId: google.maps.MapTypeId.ROADMAP
    @map = new google.maps.Map document.getElementById("map_canvas"), map_options

    try
      if typeof(navigator.geolocation) is "undefined"
        geolocation = google.gears.factory.create "beta.geolocation"
      else
        geolocation = navigator.geolocation

    if geolocation
      geolocation.watchPosition @panToPosition

  panToPosition: (position) =>
    lat = position.coords.latitude
    lon = position.coords.longitude
    @position = new google.maps.LatLng lat, lon
    @map.setCenter @position
    marker = new google.maps.Marker
      position: @position
      map: @map

if $("#map_canvas").length > 0
  gm = new GoogleMap()
