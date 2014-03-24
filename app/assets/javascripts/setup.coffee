((win, doc, $) ->
  win.App ?= {}

  win.App.$win = $ win
  win.App.$doc = $ doc
  win.App.$body = $ 'body'
)(window, document, jQuery)
