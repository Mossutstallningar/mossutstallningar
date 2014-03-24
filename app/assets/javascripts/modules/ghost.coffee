((win, doc, $, undef) ->

  Ghost =

    options:
      delay: 5000,
      fadeOutTime: 5000

    init: ->
      @$win = $ win
      @$doc = $ doc
      @$body = $ 'body'
      @$page = $ '.page'
      @$ghost = $()

      @timeout = null
      @isCreatingGhost = false
      @isFadingGhost = false

      @eventListeners()
      @setupTimeout()

    eventListeners: ->
      @$win.scroll =>
        @onWinScroll()

      @$doc.on 'PageFocus': (e, page) =>
        @$page = $(page)

      @$doc.on 'PageZero': () =>
        @$page = $()
        @fadeOutGhost() if @hasGhost()

    setupTimeout: ->
      clearTimeout @timeout
      @timeout = null

      @timeout = setTimeout =>
        if @hasPage()
          @onTimeout()
      , @options.delay

      @

    onWinScroll: ->
      unless @isCreatingGhost
        if @timeout
          clearTimeout @timeout
          @timeout = null

        if @hasPage()
          @setupTimeout()

          if @hasGhost() && !@isFadingGhost
            @fadeOutGhost()

    onTimeout: ->
      unless @isFadingGhost
        @createGhost()

    getCanvasWithAttributes: (canvas) ->
      $canvas = $ canvas

      pageOffset = @$page.offset()
      scrollOffset = @$win.scrollTop()

      $canvas.attr('id', 'ghost').css(
        left: pageOffset.left
        top: pageOffset.top - scrollOffset - scrollOffset
      )

      $canvas

    createGhost: ->
      @isCreatingGhost = true

      html2canvas(@$page.get(0),
        background: undef # transparent
        onrendered: (canvas) =>
          $canvas = @getCanvasWithAttributes canvas
          @removeGhost()
          @addGhost $canvas

          # Add a delay before saying that we are not creating a ghost anymore
          setTimeout =>
            @isCreatingGhost = false
          , 1
      )

    addGhost: ($canvas) ->
      @$body.prepend $canvas
      @$ghost = $ '#ghost'

    removeGhost: ->
      @$ghost.remove()

    hasGhost: ->
      !!@$ghost.length

    hasPage: ->
      !!@$page.length

    fadeOutGhost: ->
      @isFadingGhost = true

      @$ghost.fadeOut(@options.fadeOutTime, =>
        @isFadingGhost = false
        @removeGhost()
        @setupTimeout()
      )

  App.Ghost = Ghost

)(window, document, jQuery)
