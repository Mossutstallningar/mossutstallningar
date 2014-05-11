((win, doc, $) ->

  NavigationLines =

    init: ->
      @$canvas = $ '#navigation-lines'
      @$dashboard = $ '.dashboard'
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

      App.$doc.on 'click', '.navigation-lines-link', ->
        _.onClick $(@)

      App.$win.on 'debouncedresize', =>
        @setCanvasSize()
        @setup()

    onClick: ($el) ->
      color = $el.data 'color'

      unless $el.hasClass 'navigation-lines-last'
        offset = $el.offset()
        paddingLeft = parseInt $el.css('paddingLeft'), 10
        lineHeight = parseInt $el.css('lineHeight'), 10

        x = Math.round offset.left + paddingLeft + (paddingLeft / 3)
        y = Math.round offset.top + lineHeight - (lineHeight / 3)

        if App.Utils.isRetina()
          x = x * 2
          y = y * 2

        if @lastX && @lastY
          @drawLine x, y, color
        else
          @lastX = x
          @lastY = y

      $('.navigation-lines-last').removeClass 'navigation-lines-last'
      $el.addClass 'navigation-lines-last'

    setCanvasSize: ->
      width = App.$win.width()
      height = @$dashboard.height()

      if App.Utils.isRetina()
        attrWidth = width * 2
        attrHeight = height * 2
      else
        attrWidth = width
        attrHeight = height

      @$canvas
        .attr 'width', attrWidth
        .attr 'height', attrHeight
        .css(
          width: width,
          height: height
        )

    drawLine: (x, y, color) ->
      if App.Utils.isRetina()
        lineWidth = 20
      else
        lineWidth = 10

      @ctx.beginPath()
      @ctx.moveTo @lastX, @lastY
      @ctx.lineCap = 'round'
      @ctx.lineWidth = lineWidth
      @ctx.lineTo x ,y
      @ctx.strokeStyle = color
      @ctx.stroke()

      @lastX = x
      @lastY = y

  App.NavigationLines = NavigationLines

)(window, document, jQuery)
