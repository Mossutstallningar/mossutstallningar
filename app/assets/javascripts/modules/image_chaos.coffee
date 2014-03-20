((win, doc, $) ->

  ImageChaos =

    init: ->
      @$el = $ '.image-chaos'
      @$items = @$el.find '.image-chaos-item'
      @elWidth = @$el.width()
      @eventListeners()
      @setupDrag()
      @layoutWhenReady()

    eventListeners: ->
      _ = @

      $(win).resize =>
        @elWidth = @$el.width()
        @setLayout()

      @$items.mousedown ->
        _.bringToFront $(this)

    setupDrag: ($page) ->
      @$items.draggable(
        {
          containment: 'document'
          scroll: false
        }
      )

    bringToFront: ($item) ->
      $item.appendTo @$el

    layoutWhenReady: ->
      @$items.imagesLoaded =>
        @setLayout()

    setLayout: ->
      _ = @

      @$items.each ->
        $el = $ @

        left = App.Utils.getRandomInt 0, _.elWidth - $el.width()
        top = App.Utils.getRandomInt 0, 100

        $el.css(
          left: left
          top: top
        )

  win.App.ImageChaos = ImageChaos

)(window, document, jQuery)
