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

class window._Ardhiview
  @_instances: 0

  constructor: ->
    if $(Ardhiview.Map.Element.element_id).length > 0
      @map = new Ardhiview.Map()
      @search = new Ardhiview.Search()
      this.initListeners()
    _Ardhiview._instances += 1
  
  initListeners: ->
    $(window).resize ->
      Ardhiview.resize()