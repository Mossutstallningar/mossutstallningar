((win, doc, $) ->

  Breakpoints =

    widths:
      large: 980

    init: ->
      @$win = $ win
      @winWidth = @$win.width()
      @setBreakpointBooleans()
      @eventListeners()

    eventListeners: ->
      @$win.resize =>
        @setBreakpointBooleans()
        @winWidth = @$win.width()

    setBreakpointBooleans: ->
      @isLarge = @winWidth >= @widths.large


  win.App.Breakpoints = Breakpoints

)(window, document, jQuery)
