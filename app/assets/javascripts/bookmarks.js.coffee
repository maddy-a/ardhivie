class window.Ardhiview.Bookmarks
  visible: true
  @element_id = "#bookmarks-sidebar"
  constructor: ->
    @_initPosition()
  
  element: ->
    $(Bookmarks.element_id)

  addLocation: (location) ->
    tr = $("<tr>").append(
      $("<td>").append(location.title).addClass("title")
    ).append(
      $("<td>").append(location.address).addClass("address")
    )
    $(tr).attr("data-bookmark-id", location.id)
    tr.click ->
      Ardhiview.map().showLocation(location.id)
      Ardhiview.map()._zoom  Ardhiview.map().locations[location.id]
    @_elementTbody().append tr

  removeLocation: (location_id) ->
    @element().find("[data-bookmark-id="+location_id+"]").fadeOut()
  # private methods
  _initPosition: ->
    if @visible
      @element().css 
        marginLeft: 0
    else
      width = @element().width()
      @element().css
        marginLeft: -1 * (width + 20)
  
  _elementTbody: =>
    $(Bookmarks.element_id + " .table tbody")