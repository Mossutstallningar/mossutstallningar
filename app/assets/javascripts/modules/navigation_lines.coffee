((win, doc, $) ->

  NavigationLines =

    init: ->
      @$canvas = $ '#navigation-lines'
      if !!@$canvas.length
        @$doc = $ doc
        @ctx = @$canvas.get(0).getContext '2d'
        @lastX = null
        @lastY = null
        @setCanvasSize()
        @eventListeners()
        @setup()

    setup: ->
      @ctx.globalAlpha = 0.5
      @ctx.moveTo 0, 0

    eventListeners: ->
      _ = @

      @$doc.on 'click', '.navigation-lines-link', (e) ->
        _.onClick e, $(@)

      $(win).resize =>
        _.setCanvasSize()
        _.setup()

    onClick: (e, $el) ->
      color = $el.data 'color'

      unless $el.hasClass 'navigation-lines-last'
        x = e.pageX * 2
        y = e.pageY * 2

        if @lastX && @lastY
          @drawLine x, y, color
        else
          @lastX = x
          @lastY = y

      $('.navigation-lines-last').removeClass 'navigation-lines-last'
      $el.addClass 'navigation-lines-last'

    setCanvasSize: ->
      width = $(win).width()
      height = $(win).height()

      @$canvas
        .attr 'width', width * 2
        .attr 'height', height * 2
        .css(
          width: width,
          height: height
        )

    drawLine: (x, y, color) ->
      @ctx.beginPath()
      @ctx.moveTo @lastX, @lastY
      @ctx.lineCap = 'round'
      @ctx.lineWidth = 20
      @ctx.lineTo x ,y
      @ctx.strokeStyle = color
      @ctx.stroke()

      @lastX = x
      @lastY = y

  App.NavigationLines = NavigationLines

)(window, document, jQuery)
