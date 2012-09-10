class window.Ardhiview.Location
  
  _location_id: null
  _marker: null
  _infoWindow: null
  _latitude: null
  _longitude: null
  _address: null
  _title: null
  _saved: false
  _infoBubble: null
  # construt with {latitude: <>, longitude: <>, title: <>, address: <>}
  constructor: (location, newLocation) ->
    @_latitude = location.latitude
    @_longitude = location.longitude
    @_address = location.address
    @_title = location.title
    @_location_id = location.id
    
    @_initMarker()
    if newLocation?
      @_initNewLocationForm()
    else
      @_initInfoBubble()
      @_saved = true
      @_initInfoWindow()
  
  saved: (location)->
    @_saved = true
    @_location_id = location.id
    @_title = location.title
    @_address = location.address
    $('#new-location-form').modal('hide')
    @_initInfoWindow()
    @_initInfoBubble()
    @showWindow()
  
  is_saved: -> 
    @_saved == true
  
  destroy: ->
    if @is_saved()
      $.ajax 
        type: "DELETE"
        dataType: "json"
        url: "/api/locations/"+@_location_id+".json"
      @hideWindow()
      delete @_infoWindow
      @removeMarker()
      
  removeMarker: ->
    @_marker.setMap null
    delete @_marker
  
  showWindow: ->
    Ardhiview.map().openLocation.hideWindow() if Ardhiview.map().openLocation != null
    Ardhiview.map().currentLocation this
    if @is_saved()
      @_infoWindow.open Ardhiview.map().googleMap, @_marker
      that = this
      $('.fileupload').fileupload({prependFiles: true})
      $('.fileupload').each ->
        $.getJSON "/api/locations/"+that._location_id+"/ufiles.json", (result) =>
          if (result && result.length)
            $(this).fileupload('option', 'done')
              .call(this, null, {result: result})
            $(this).data("existing-files-loaded",true)
    
  hideWindow: ->
    Ardhiview.map().currentLocation null
    if @is_saved()
      @_infoWindow.close()

  # private methods
  _initInfoBubble: ->
    @_infoBubble = new InfoBubble 
      position: @_marker.getPosition()
      content: "<div class='phoneytext'>"+@_title+"</div>"
      shadowStyle: 1
      padding: 0
      backgroundColor: 'rgb(57,57,57)'
      borderRadius: 4
      arrowSize: 10
      borderWidth: 1
      borderColor: '#2c2c2c'
      disableAutoPan: true
      hideCloseButton: true
      arrowPosition: 30
      backgroundClassName: 'phoney'
      arrowStyle: 2
  
  _initMarker: ->
    @_marker = new google.maps.Marker {
      map: Ardhiview.map().googleMap
      position: new google.maps.LatLng @_latitude, @_longitude
    }
    $(@_marker).data("location", this)

    google.maps.event.addListener @_marker, 'click', =>
      @showWindow()
    
    google.maps.event.addListener @_marker, 'mouseover', =>
      @_infoBubble.open Ardhiview.map().googleMap, @_marker
      $(Ardhiview.Search.element_id).val @_address

    google.maps.event.addListener @_marker, 'mouseout', =>
      @_infoBubble.close()
      $(Ardhiview.Search.element_id).val ""

  _initInfoWindow: ->
    @_infoWindow = new google.maps.InfoWindow {
      content: @_getForm()
    }
    
    google.maps.event.addListener @_infoWindow, 'closeclick', =>
      @hideWindow()
    
  _getForm: ->
    return tmpl("template-ufile-form",{location_id: @_location_id, title: @_title, address: @_address})
  
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
      unless @is_saved()
        Ardhiview.map()._removeNewLocation()