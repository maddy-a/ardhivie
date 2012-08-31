class window.Ardhivie
  constructor: ->
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
    @map = new google.maps.Map(document.getElementById('map'), options)
    this.setInfo()
  
  setInfo: ->
    @infoWindow = new google.maps.InfoWindow({
      content: $('<div>').append(this.getForm()).html()
    });
    return
    
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
            google.maps.event.addListener marker, 'click', =>
              @infoWindow.open(@map,marker);
              return
    })
  
  getForm: ->
    td = $("<td>").append("Name:")
    tr = $("<tr>").append(td)
    input = $("<input>", {type: 'text', name: 'ufile[name]', size: "30"})
    td = $("<td>").append(input)
    tr.append(td)
    table = $("<table>").append(tr)
    input = $("<input>", {type: 'submit', value: 'New'})
    td = $("<td>", {align: "right", colspan: "2"}).append(input)
    tr = $("<tr>").append(td)
    table.append(tr)
    $("<form>", {method: "post", action: '/ufiles'}).append(table)