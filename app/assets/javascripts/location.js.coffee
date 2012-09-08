class window.Ardhiview.Location

  _marker: null
  _latitude: null
  _longitude: null
  _address: null
  _title: null
  _saved: false
  # construt with {latitude: <>, longitude: <>, title: <>, address: <>}
  constructor: (location, newLocation) ->
    @_latitude = location.latitude
    @_longitude = location.longitude
    @_address = location.address
    @_title = location.title
    
    @_initMarker()
    if newLocation?
      @_initNewLocationForm()
  
  saved: ->
    @_saved = true
    $('#new-location-form').modal('hide')
  
  destroy: ->
    @_marker.setMap null

  # private methods
  _initMarker: ->
    @_marker = new google.maps.Marker {
      map: Ardhiview.map().googleMap
      position: new google.maps.LatLng @_latitude, @_longitude
    }
  
  _initNewLocationForm: ->
    $('#new-location-form').data("location", this)
    $('#location_address').val @_address
    $('#location_latitude').val @_latitude
    $('#location_longitude').val @_longitude
    $('#new-location-form .location-display-lat').text (Math.round(@_latitude*10)/10).toFixed(2)
    $('#new-location-form .location-display-lng').text (Math.round(@_longitude*10)/10).toFixed(2)
    setTimeout ->
      $('#new-location-form').modal('show')
    , '200'
    $('#new-location-form').on 'hidden', =>
      unless @_saved
        Ardhiview.map()._removeNewLocation()