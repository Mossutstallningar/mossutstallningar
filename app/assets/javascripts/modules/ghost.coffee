((win, doc, $, undef) ->

  Ghost =

    options:
      delay: 5000,
      fadeOutTime: 5000

    init: ->
      @$page = $ '.page'
      @$ghost = $()

      @timeout = null
      @isCreatingGhost = false
      @isFadingGhost = false

      @eventListeners()
      @setupTimeout()

    eventListeners: ->
      App.$win.scroll =>
        @clearAndFadeout()

      App.$doc.on 'PageFocus': (e, data) =>
        @$page = data.$page

      App.$doc.on 'PageZero': =>
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

    clearAndFadeout: ->
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
      scrollOffset = App.$win.scrollTop()

      $canvas.attr('id', 'ghost').css(
        left: pageOffset.left
        top: pageOffset.top - scrollOffset - scrollOffset
      )

      $canvas

    createGhost: ->
      @isCreatingGhost = true

      html2canvas(@$page.get(0),
        background: undef # transparent
        useCORS: true
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
      App.$body.prepend $canvas
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
