$ ->
  $.fn.enterKey = (handler) ->
    $(this).keydown (e) ->
      if (e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)
        handler.apply(e.currentTarget, [e]);
  return