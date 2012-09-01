class window.Ardhivie
  constructor: ->
    if $("#google-map").length > 0
      latlng = new google.maps.LatLng(37.09, -95.71)
      options = {
        zoom: 5
        zoomControl: true 
        center: latlng
        mapTypeId: google.maps.MapTypeId.ROADMAP
        disableDefaultUI: true
        disableDoubleClickZoom: true
        noClear: true
        navigationControl: true
        navigationControlOptions: {
          position: google.maps.ControlPosition.TOP_RIGHT
        }
      }
      @map = new google.maps.Map(document.getElementById('google-map'), options)
      # this.setInfo()
      this.getLocations()
    
  getInfo: (locationId)->
    new google.maps.InfoWindow({
      content: $('<div>').append(locationId).append(this.getForm(locationId)).html()
    });
    
  getFiles: ->
    $.ajax({
      type: "GET"
      dataType: "json"
      url: "/ufiles"
      success: (data) ->
        str = "<table>"
        for file in data
          do (d) ->
            str= str + "<tr><td>" + file.name + "<td></tr>"
        str = str + "</table>"
    })
  
  getLocations: ->
    $.ajax({
      type: "GET"
      dataType: "json"
      url: "/locations"
      success: (data) =>
        for location in data 
          do (location) =>
            marker_latlng = new google.maps.LatLng location.latitude, location.longitude
            loc_id = location.id
            marker = new google.maps.Marker({ position: marker_latlng, map: @map, title: 'Click me'})
            $(marker).data("location-id",loc_id)
            google.maps.event.addListener marker, 'click', =>
              this.getInfo(loc_id).open(@map,marker);
              return
    })
  
  getForm: (location_id)->
    form = ""
    $.ajax {
      url: "/ufiles/get_form"
      data: {location_id: location_id}
      success: (html) ->
        form = html
      async:false
    }
    return form