class window.Ardhiview.Map.Element
  @element_id = "#google-map"
  
  constructor: ->
    @_initWidth()
  
  resize: ->
    @_initWidth()
  
  getDOMElement: ->
    @_element().get(0)
  
  expand: (handler) ->
    @_element().animate
      width: $(".container-fluid").width()-2
    , 
      duration: 200
      queue: false
      complete: ->
        Ardhiview.map().resize()
  
  shrink: ->
    @_element().animate
      width: $(".container-fluid").width()-22-Ardhiview.bookmarks().element().width()
    , 
      duration: 200
      queue: false
      complete: ->
        Ardhiview.map().resize()
        
  # private methods
  _initWidth: ->
    if Ardhiview.bookmarksVisible()
      @_element().width($(".container-fluid").width()-22-Ardhiview.bookmarks().element().width())
    else
      @_element().width($(".container-fluid").width()-2)

  _element: ->
    $(Element.element_id)