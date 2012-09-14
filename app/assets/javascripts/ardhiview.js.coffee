class window.Ardhiview
  _instance = undefined # Must be declared here to force the closure on the class
  
  @get: -> # Must be a static method
    if _instance?
      _instance
    else  
      _instance = new _Ardhiview()
      _instance.init()
      $("#content").fadeIn()

  @show: ->
    

  @map: ->
    @get().map

  @search: ->
    @get().search

  @bookmarks: ->
    @get().bookmarks

  @resize: ->
    @map().resize()
    @search().resize()
  
  @findAddress: (address) ->
    @map().findAddress address
  
  @showAlert: (alert) ->
    $("#message .alert-message").text(alert)
    $("#message").fadeIn()

  @bookmarksVisible: ->
    @bookmarks().visible

class window._Ardhiview
  @_instances: 0
  
  constructor: ->
    _Ardhiview._instances += 1
  
  init: ->
    if $(Ardhiview.Map.Element.element_id).length > 0
      @bookmarks = new Ardhiview.Bookmarks()
      @map = new Ardhiview.Map()
      @search = new Ardhiview.Search()
      @initListeners()
      @initLocations()
      @initMyLocations()
      
  initMyLocations: ->
    $.ajax {
      type: "GET"
      dataType: "json"
      url: "/api/locations/mine.json"
      success: (data) =>
        for location in data 
          do (location) =>
            @bookmarks.addLocation location
    }
    
  initLocations: ->
    $.ajax {
      type: "GET"
      dataType: "json"
      url: "/api/locations.json"
      success: (data) =>
        for location in data 
          do (location) =>
            @map.addLocation location
    }
  
  initListeners: ->
    $(window).resize ->
      Ardhiview.resize()
    
    $(".close-alert-message").live "click", ->
      $(this).parents(".alert").fadeOut()
      return false
    
    $(".delete-location").live "click", ->
      if confirm("Are you sure you want to remove the location from the system?")
        Ardhiview.map().deleteLocation $(this).data('location-id')
        return false
    $("#new-location-form input").enterKey ->
      $("#new-location-form .save-new-location").click()

    $("#new-location-form .save-new-location").live "click", =>
      if $('#location_title').val() == ''
        $('#location_title').parents(".control-group").addClass("error")
        $('#location_title').focus()
        return false
      else
        $.post(
          "/api/locations.json"
          $('#new-location-form form').serializeJSON()
        ).success( (data) =>
          location = $('#new-location-form').data("location")
          location.save(data)
          @map.locations[location._location_id] = location
          @bookmarks.addLocation data
        ).error( (data)->
          $('#new-location-form .alert').fadeIn()
        )