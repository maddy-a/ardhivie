$ ->
  $.widget 'blueimpUIX.fileupload', $.blueimpUI.fileupload,
    options:
      destroy: (e, data) ->
        if confirm("Do you really want to delete this file?")
          $.blueimpUI.fileupload.prototype
            .options.destroy.call(this, e, data);
  