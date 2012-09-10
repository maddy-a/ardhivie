class window.Ardhiview.Map
  
  element: null
  googleMap: null
  geoCoder: null
  centerLatlng: null
  openLocation: null
  locations: {}
  clusterer: null

  constructor: ->
    @element = new Map.Element()
    @googleMap = new google.maps.Map(@element.getDOMElement(), @_mapOptions())
    @geoCoder = new google.maps.Geocoder()
    @clusterer = new MarkerClusterer(@googleMap,[])
    @locations = {}
    @_addResetControl()
    @_initListners()
  
  reset: ->
    
  findAddress: (address) ->
    @geoCoder.geocode { 'address': address}, (results, status) =>
      if (status == google.maps.GeocoderStatus.OK)
        location = results[0].geometry.location
        @addLocation {address: address, latitude: location.lat(), longitude: location.lng()}
      else
        Ardhiview.showAlert('Geocode was not successful for the following reason: ' + status)
  
  addLocation: (data) ->
    location = new Ardhiview.Location data
    @clusterer.addMarker location._marker
    @clusterer.redraw()
    if location.is_saved()
      @locations[location._location_id] = location
    else
      @setOpenLocation location
      @_zoom location
    
  deleteLocation: (location_id) ->
    @locations[location_id].destroy()
    delete @locations[location_id]
  
  setOpenLocation: (location) ->
    if @openLocation != null
      unless @openLocation.is_saved()
        @openLocation.removeMarker()
    @openLocation = location
    
  resize: ->
    center = @googleMap.getCenter()
    @element.resize()
    @reset()
    @googleMap.setCenter(center)
    
  # private methods
  _zoom: (location)->
    w = null
    unless @openLocation == null || !@openLocation.is_saved()
      w = @openLocation
      @openLocation.hideWindow()
    @googleMap.setCenter new google.maps.LatLng location._latitude, location._longitude
    @googleMap.setZoom 18
    @markers.resetViewport()
    @markers.redraw()
    unless w == null
      w.showWindow() 
  
  _initListners: ->
    that = this
    $(".zoomin-button").live "click", ->
      location_id = $(this).data("location-id")
      that._zoom that.locations[location_id]
      return false
    
    $(".reset-control").live "click", =>
      @openLocation.hideWindow() unless @openLocation == null
      @reset()
      @googleMap.setCenter(@_mapOptions().center)
      @googleMap.setZoom(@_mapOptions().zoom)
    
    google.maps.event.addListener @googleMap, 'click', (event) =>
      @openLocation.hideWindow()

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

  