class window.Ardhiview.Location

  _marker: null
  _latitude: null
  _longitude: null
  _address: null
  _title: null
  
  # construt with {latitude: <>, longitude: <>, title: <>, address: <>}
  constructor: (location, newLocation) ->
    @_latitude = location.latitude
    @_longitude = location.longitude
    @_address = location.address
    @_title = location.title
    
    @_initMarker()
    if newLocation?
      @_initNewLocationForm()
  
  destroy: ->
    @_marker.setMap null

  # private methods
  _initMarker: ->
    @_marker = new google.maps.Marker {
      map: Ardhiview.map().googleMap
      position: new google.maps.LatLng @_latitude, @_longitude
    }
  
  _initNewLocationForm: ->
    $('#new-location-form .location-address').val @_address
    $('#new-location-form .location-lat').text (Math.round(@_latitude*10)/10).toFixed(2)
    $('#new-location-form .location-lng').text (Math.round(@_longitude*10)/10).toFixed(2)
    setTimeout ->
      $('#new-location-form').modal('show')
    , '200'
    $('#new-location-form').on 'hidden', =>
      Ardhiview.map()._removeNewLocation()