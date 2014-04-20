((win, doc, $) ->

  Tooltip =

    init: ->
      @$tooltipTrigger = $ '.tooltip-trigger'
      @$tooltip = $()
      @tooltipWidth = 330
      @winWidth = App.$win.width()
      @eventListeners()

    eventListeners: ->
      _  = @

      @$tooltipTrigger.mouseenter ->
        _.$tooltip = $(@).siblings '.tooltip'
        _.show()

      @$tooltipTrigger.mouseleave ->
        _.hide()
        _.$tooltip = $()

      @$tooltipTrigger.mousemove (e) ->
        _.move e.pageX, e.pageY

      App.$win.on 'debouncedresize', =>
        @winWidth = App.$win.width()

    show: ->
      @$tooltip.show()

    hide: ->
      @$tooltip.hide()

    move: (x, y) ->
      if x > (@winWidth - @tooltipWidth)
        left = x - @tooltipWidth
      else
        left = x
      top = y

      @$tooltip.css(
        left: left
        top: top
      )

  App.Tooltip = Tooltip

)(window, document, jQuery)
