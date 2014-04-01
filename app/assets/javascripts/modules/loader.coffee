((win, doc, $) ->

  Loader =

    init: ->
      @$el = $ '.loader'
      @eventListeners()

    eventListeners: ->
      App.$doc.on 'PageLoad': =>
        @onPageLoad()

      App.$doc.on 'PageAdd': =>
        @onPageAdd()

    onPageLoad: ->
      @show()

    onPageAdd: ->
      @hide()

    show: ->
      @$el.addClass 'loader-loading'

    hide: ->
      @$el.removeClass 'loader-loading'

  App.Loader = Loader

)(window, document, jQuery)
