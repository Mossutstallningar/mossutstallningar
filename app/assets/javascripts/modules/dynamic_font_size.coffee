((win, doc, $) ->

  DynamicFontSize =

    init: ->
      @$els = $('.dynamic-font-size').add $('.dynamic-font-size-children').children()
      @$elChilds = $ '.dynamic-font-size-children'
      @eventListeners()

    eventListeners: ->
      $(win).resize =>
        @rePaint()

    rePaint: ->
      @$els.css 'zIndex', 'auto'

  App.DynamicFontSize = DynamicFontSize

)(window, document, jQuery)
