class window.Ardhiview.Map.Element
  @element_id = "#google-map"
  
  constructor: ->
    @_initWidth()
  
  resize: ->
    @_initWidth()
  
  getDOMElement: ->
    @_element().get(0)
  
  # private methods
  _initWidth: ->
    # @_element().width("100%")
    @_element().width($(".container-fluid").width()-2)

  _element: ->
    $(Element.element_id)