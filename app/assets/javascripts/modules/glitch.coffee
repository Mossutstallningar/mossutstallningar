((win, doc, $) ->

  Glitch =

    init: ->
      @imgSelector = '.image-with-caption-image[src$=".jpg"]'
      @$els = null
      @setElements()
      @setup @$els
      @eventListeners()

    eventListeners: ->
      App.$doc.on 'PageAdd': (e, data) =>
        @onPageAdd data.$page

      App.$doc.on 'PageClose': =>
        @onPageClose()

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
        $el = $ @
        $el.glitch()
        $el.imagesLoaded ->
          setTimeout ->
            _.setupMousemove $el
            _.setupShare $el
          , 100

    setupMousemove: ($el) ->
      $glitchCanvasWrapper = $el.siblings '.glitch-canvas-wrapper'
      $glitchCanvasWrapper.mousemove($.throttle(300, =>
          console.log('gli')
          $el.data('Glitch').draw() if $el.data 'GlitchReady'
        )
      )

    setupShare: ($el) ->
      $glitchCanvasWrapper = $el.siblings '.glitch-canvas-wrapper'

      src = $el.attr 'src'
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
