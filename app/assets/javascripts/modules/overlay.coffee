((win, doc, $) ->

  Overlay =

    options:
      delay: 10000

    init: ->
      @$overlay = $ '.overlay'
      @timeout = null
      @active = false

      @setupTimeout()
      @eventListeners()

    eventListeners: ->
      App.$doc
      .mousemove =>
        @onMovement()
      .on 'touchstart', =>
        @onMovement()

    onMovement: ->
      @setupTimeout()
      @fadeOut() if @active

    setupTimeout: ->
      clearTimeout @timeout
      @timeout = null

      @timeout = setTimeout =>
        @onTimeout()
      , @options.delay

    onTimeout: ->
      @fadeIn()

    clearAndFadeout: ->
      @setupTimeout()

    fadeIn: ->
      @active = true
      @$overlay.stop().fadeIn 5000

    fadeOut: ->
      @active = false
      @$overlay.stop().fadeOut 500

  App.Overlay = Overlay

)(window, document, jQuery)
