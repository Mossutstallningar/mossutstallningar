((win, doc, $) ->

  Loader =

    init: ->
      @$doc = $ doc
      @$el = $ '.loader'
      @eventListeners()

    eventListeners: ->
      @$doc.on 'PageLoad': () =>
        @onPageLoad()

      @$doc.on 'PageAdd': () =>
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
