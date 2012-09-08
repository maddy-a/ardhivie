class window.Ardhiview.Map
  
  element: null
  googleMap: null
  centerLatlng: null
  openLocation: null
  locations: null

  constructor: ->
    @element = new Map.Element()
    @googleMap = new google.maps.Map(@element.getDOMElement(), @_mapOptions())

    @_addResetControl()
    @_initListners()
  
  reset: ->
    
  
  resize: ->
    center = @googleMap.getCenter()
    @element.resize()
    @reset()
    @googleMap.setCenter(center)
    
  # private methods
  _initListners: ->
    $(".zoomin-button").live "click", ->
      location_id = $(this).data("location-id")
      # Ardhiview.map().zoomMap Ardhiview.map().markerHash[location_id]
      return false
    
    $(".reset-control").live "click", =>
      # google.maps.event.addDomListener homeControlDiv, 'click', =>
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

  