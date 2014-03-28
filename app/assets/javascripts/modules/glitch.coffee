((win, doc, $) ->

  Glitch =

    init: ->
      @imgSelector = '.image-with-caption-image[src$=".jpg"]'
      @$els = null
      @setElements()
      @setup @$els
      @eventListeners()

    eventListeners: ->
      App.$doc.mousemove =>
        @onMovement()

      App.$doc.on 'PageAdd': (e, page) =>
        @onPageAdd $(page)

      App.$doc.on 'PageClose': () =>
        @onPageClose()

      App.$win.scroll =>
        @onMovement()

    onMovement: ->
      @$els.each ->
        $el = $ @
        $el.data('Glitch').draw() if $el.data 'GlitchReady'

    onPageAdd: ($page) ->
      $els = $page.find @imgSelector
      @setup $els
      @setElements()

    onPageClose: ->
      @setElements()

    setElements: ->
      @$els = $ @imgSelector

    setup: ($els) ->
      $els.glitch()

  App.Glitch = Glitch

)(window, document, jQuery)
