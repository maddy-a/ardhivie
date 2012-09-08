class window.Ardhiview.Search
  @element_id: "#search"
  
  constructor: ->
    @_initWidth()
    @_initListners()
  
  resize: ->
    @_initWidth()

  # private methods
  _initWidth: ->
    @_element().width($(".container-fluid").width() - $(".input-prepend span.add-on").width() - 24)
  
  _element: ->
    $(Search.element_id)
    
  _initListners: ->
    @_element().enterKey ->
      Ardhiview.findAddress $(this).val()
  
  