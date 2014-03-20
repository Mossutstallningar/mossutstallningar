((win, doc, $) ->

  DynamicFontSize =

    init: ->
      @$doc = $ doc
      @setElements()
      @eventListeners()

    setElements: ->
      @$els =
        $('.dynamic-font-size')
        .add $('.dynamic-font-size-children').children()

    eventListeners: ->
      $(win).on 'debouncedresize', =>
        @rePaint()

      @$doc.on 'PageAdd': () =>
        @setElements()

    rePaint: ->
      @$els.css 'zIndex', 'auto'

  App.DynamicFontSize = DynamicFontSize

)(window, document, jQuery)
