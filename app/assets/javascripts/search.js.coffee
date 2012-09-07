class window.Ardhiview.Search
  @element_id: "#search"
  
  constructor: ->
    @_initWidth()
  
  resize: ->
    @_initWidth()

  # private methods
  _initWidth: ->
    @_element().width($(".container-fluid").width() - $(".input-prepend span.add-on").width() - 24)
  
  _element: ->
    $(Search.element_id)
  
  