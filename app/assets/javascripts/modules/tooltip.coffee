((win, doc, $) ->

  Tooltip =

    init: ->
      @$tooltipTrigger = $ '.tooltip-trigger'
      @$tooltip = $()
      @tooltipWidth = 330
      @tooltipHeight = 0
      @winWidth = App.$win.width()
      @winHeight = App.$win.height()
      @eventListeners()

    eventListeners: ->
      _  = @

      @$tooltipTrigger.mouseenter ->
        _.$tooltip = $(@).siblings '.tooltip'
        _.show()
        _.tooltipHeight = _.getTooltipHeight()

      @$tooltipTrigger.mouseleave ->
        _.hide()
        _.$tooltip = $()

      @$tooltipTrigger.mousemove (e) ->
        _.move e.pageX, e.pageY

      App.$win.on 'debouncedresize', =>
        @winWidth = App.$win.width()
        @winHeight = App.$win.height()

    show: ->
      @$tooltip.show()

    hide: ->
      @$tooltip.hide()

    getTooltipHeight: ->
      @$tooltip.height()

    move: (x, y) ->
      if x > (@winWidth - @tooltipWidth)
        left = x - @tooltipWidth
      else
        left = x

      if y > (@winHeight - @tooltipHeight)
        top = y - @tooltipHeight
      else
        top = y

      @$tooltip.css(
        left: left
        top: top
      )

  App.Tooltip = Tooltip

)(window, document, jQuery)
