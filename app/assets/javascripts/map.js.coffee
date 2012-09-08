class window.Ardhiview.Map
  
  element: null
  googleMap: null
  geoCoder: null
  centerLatlng: null
  openLocation: null
  locations: null
  newLocation: null

  constructor: ->
    @element = new Map.Element()
    @googleMap = new google.maps.Map(@element.getDOMElement(), @_mapOptions())
    @geoCoder = new google.maps.Geocoder()

    @_addResetControl()
    @_initListners()
  
  reset: ->
    @_removeNewLocation()
    
  findAddress: (address) ->
    @geoCoder.geocode { 'address': address}, (results, status) =>
      if (status == google.maps.GeocoderStatus.OK)
        @_addNewLocation results[0].geometry.location
      else
        Ardhiview.showAlert('Geocode was not successful for the following reason: ' + status)
  
  resize: ->
    center = @googleMap.getCenter()
    @element.resize()
    @reset()
    @googleMap.setCenter(center)
    
  # private methods
  _zoom: (location)->
    @googleMap.setCenter location
    @googleMap.setZoom 18
  
  _removeNewLocation: ->
    unless @newLocation == null
      @newLocation.setMap null
  
  _addNewLocation: (location) ->
    @_removeNewLocation()
    @newLocation = new google.maps.Marker {
      map: @googleMap
      position: location
      animation: google.maps.Animation.DROP
      icon: 'http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png'
    }
    @_zoom location
    
  
  _initListners: ->
    $(".zoomin-button").live "click", ->
      location_id = $(this).data("location-id")
      # Ardhiview.map().zoomMap Ardhiview.map().markerHash[location_id]
      return false
    
    $(".reset-control").live "click", =>
      @reset()
      @googleMap.setCenter(@_mapOptions().center)
      @googleMap.setZoom(@_mapOptions().zoom)
    

  _debug: ->
    console.log this
    
  _mapOptions: ->
    {
      zoom: 5
      zoomControl: true 
      center: new google.maps.LatLng(39.50, -98.35)
      mapTypeId: google.maps.MapTypeId.ROADMAP
      mapTypeControl: true
      disableDefaultUI: true
      disableDoubleClickZoom: true
      noClear: true
      navigationControlOptions: {
        position: google.maps.ControlPosition.TOP_RIGHT
      }
    }
  
  _addResetControl: ->
    homeControlDiv = document.createElement('div')
    controlDiv = $("<div>")
    controlDiv.text "Reset"
    controlDiv.appendTo($(homeControlDiv).addClass("reset-control"))
    homeControlDiv.index = 1;
    @googleMap.controls[google.maps.ControlPosition.TOP_RIGHT].push homeControlDiv

  