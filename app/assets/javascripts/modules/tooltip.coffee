((win, doc, $) ->

  Tooltip =

    init: ->
      @$tooltipTrigger = $ '.tooltip-trigger'
      @$tooltip = $()
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

    show: ->
      @$tooltip.show()

    hide: ->
      @$tooltip.hide()

    move: (x, y) ->
      @$tooltip.css(
        left: x
        top: y
      )

  App.Tooltip = Tooltip

)(window, document, jQuery)
