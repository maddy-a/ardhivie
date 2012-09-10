class window.Ardhiview
  _instance = undefined # Must be declared here to force the closure on the class
  
  @get: -> # Must be a static method
    _instance ?= new _Ardhiview

  @map: ->
    @get().map

  @search: ->
    @get().search

  @resize: ->
    @map().resize()
    @search().resize()
  
  @findAddress: (address) ->
    @map().findAddress address
  
  @showAlert: (alert) ->
    $("#message .alert-message").text(alert)
    $("#message").fadeIn()

class window._Ardhiview
  @_instances: 0

  constructor: ->
    if $(Ardhiview.Map.Element.element_id).length > 0
      @map = new Ardhiview.Map()
      @search = new Ardhiview.Search()
      @initListeners()
      @initLocations()
    _Ardhiview._instances += 1
  
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
        ).error( (data)->
          $('#new-location-form .alert').fadeIn()
        )