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
        @winWidth = @$win.width()
        @setBreakpointBooleans()

    setBreakpointBooleans: ->
      @isLarge = @winWidth >= @widths.large


  win.App.Breakpoints = Breakpoints

)(window, document, jQuery)
