((win, doc, $) ->

  DynamicFontSize =

    init: ->
      @setElements()
      @eventListeners()

    setElements: ->
      @$els =
        $('.dynamic-font-size')
        .add $('.dynamic-font-size-children').children()

    eventListeners: ->
      App.$win.on 'debouncedresize', =>
        @rePaint()

      App.$doc.on 'PageAdd': () =>
        @setElements()

    rePaint: ->
      @$els.css 'zIndex', 'auto'

  App.DynamicFontSize = DynamicFontSize

)(window, document, jQuery)
