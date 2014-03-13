((win, doc, $) ->

  DynamicFontSize =

    init: ->
      @$el = $ '.dynamic-font-size'
      @eventListeners()

    eventListeners: ->
      $(win).resize =>
        @rePaint()

    rePaint: ->
      @$el.css 'zIndex', 'auto'

  App.DynamicFontSize = DynamicFontSize

)(window, document, jQuery)
