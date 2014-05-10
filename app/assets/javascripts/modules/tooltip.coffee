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
        $el = $ @

        isRelative = !!$el.data 'tooltip-relative'

        x = e.pageX
        y = e.pageY

        if isRelative
          elOffset = $el.offset()
          x = x - elOffset.left
          y = y - elOffset.top
          xMax = _.winWidth - elOffset.left - _.tooltipWidth
          yMax = _.winHeight - elOffset.top - _.tooltipHeight - 60
        else
          xMax = _.winWidth - _.tooltipWidth
          yMax = _.winHeight - _.tooltipHeight - 60

        _.move x, y, xMax, yMax

      App.$win.on 'debouncedresize', =>
        @winWidth = App.$win.width()
        @winHeight = App.$win.height()

    show: ->
      @$tooltip.show()

    hide: ->
      @$tooltip.hide()

    getTooltipHeight: ->
      @$tooltip.height()

    move: (x, y, xMax, yMax) ->
      if x > xMax
        left = x - @tooltipWidth
      else
        left = x

      if y > yMax
        top = yMax
      else
        top = y

      @$tooltip.css(
        left: left
        top: top
      )

  App.Tooltip = Tooltip

)(window, document, jQuery)
