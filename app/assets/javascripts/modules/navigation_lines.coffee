((win, doc, $) ->

  NavigationLines =

    init: ->
      @$doc = $ doc
      @$canvas = $ '#navigation-lines'
      @ctx = @$canvas.get(0).getContext '2d'
      @lastX = null
      @lastY = null
      @setCanvasSize()
      @eventListeners()
      @setupPath()

    setupPath: ->
      @ctx.moveTo 0, 0

    eventListeners: ->
      @$doc.on 'click', '.internal', (e) =>
        @onClick e

      $(win).resize =>
        @setCanvasSize()

    onClick: (e) ->
      e.preventDefault()
      x = e.pageX
      y = e.pageY

      if @lastX && @lastY
        @drawLine x, y
      else
        @lastX = x
        @lastY = y

    setCanvasSize: ->
      width = $(win).width()
      height = $(win).height()

      @$canvas
        .attr 'width', width
        .attr 'height', height
        .css(
          width: width,
          height: height
        )

    drawLine: (x, y) ->
      @ctx.beginPath()
      @ctx.moveTo @lastX, @lastY
      @ctx.lineCap = 'round'
      @ctx.lineWidth = 10
      @ctx.lineTo x ,y
      @ctx.strokeStyle = @getRandomColor()
      @ctx.stroke()

      @lastX = x
      @lastY = y

    getRandomColor: ->
      color = 'rgba('
      color += Math.floor(Math.random() * 255) + ',' for [1..3]
      color += '0.5)'

      color

  App.NavigationLines = NavigationLines

)(window, document, jQuery)
