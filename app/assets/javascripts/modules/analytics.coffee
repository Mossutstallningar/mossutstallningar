((win, doc, $)->

  Analytics =

    init: ->
      @eventListeners()

    eventListeners: ->
      App.$doc.on 'PageAdd': (e, data) =>
        _gaq.push ['_trackPageview', data.href] if data and data.href

  win.App.Analytics = Analytics

)(window, document, jQuery)
