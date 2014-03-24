((win, doc, $) ->

  Breakpoints =

    # If you update these - also update variables in
    # app/assets/stylesheets/helpers/_variables.scss
    widths:
      large: 980
      medium: 650

    init: ->
      @winWidth = App.$win.width()
      @setBreakpointBooleans()
      @eventListeners()

    eventListeners: ->
      App.$win.resize =>
        @setBreakpointBooleans()
        @winWidth = App.$win.width()

    setBreakpointBooleans: ->
      @isLarge = @winWidth >= @widths.large
      @isMedium = @winWidth >= @widths.medium


  win.App.Breakpoints = Breakpoints

)(window, document, jQuery)
