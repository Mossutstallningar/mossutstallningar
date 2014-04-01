((win, doc, $) ->

  Glitch =

    init: ->
      @imgSelector = '.image-with-caption-image[src$=".jpg"]'
      @$els = null
      @setElements()
      @setup @$els
      @eventListeners()

    eventListeners: ->
      App.$doc.mousemove(
        $.throttle(100, =>
          @onMovement()
        )
      )

      App.$doc.on 'PageAdd': (e, data) =>
        @onPageAdd data.$page

      App.$doc.on 'PageClose': =>
        @onPageClose()

      App.$win.scroll(
        $.throttle(100, =>
          @onMovement()
        )
      )

    onMovement: ->
      if !!@$els.length
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
      _ = @

      $els.each ->
        $el = $(@)
        $el.glitch()
        $el.imagesLoaded ->
          setTimeout ->
            _.setupShare $el
          , 100

    setupShare: ($el) ->
      $glitchCanvasWrapper = $el.siblings '.glitch-canvas-wrapper'

      src = $el.attr('src')
      credit = $el.siblings('.image-with-caption-caption').text()

      imageButtons = App.Utils.template(
        App.Templates.imageButtons,
        {
          src: src
          credit: credit
        }
      )

      $glitchCanvasWrapper.append imageButtons

  App.Glitch = Glitch

)(window, document, jQuery)
