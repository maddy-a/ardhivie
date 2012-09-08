$ ->
  $.fn.enterKey = (handler) ->
    $(this).keydown (e) ->
      if (e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)
        handler.apply(e.currentTarget, [e]);
  
  $.fn.serializeJSON = ->
    json = {}
    jQuery.map $(this).serializeArray(), (n,i) ->
      json[n['name']] = n['value']
    return json;
