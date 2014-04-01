((win, doc, $) ->

  Preload =

    init: ->
      @createElements()

    createElements: ->
      html = ''
      for i in [0..2]
        html += "<div class='preload' id='preload-#{i}'></div>"

      App.$body.append(html)

  App.Preload = Preload

)(window, document, jQuery)
