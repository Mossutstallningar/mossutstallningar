((win, doc, $) ->

  ImageChaos =

    init: ->
      @$doc = $ doc
      @els = $ '.image-chaos'

      $imageChaos = $ '.image-chaos'

      @eventListeners()
      @setup $imageChaos if !!$imageChaos.length

    eventListeners: ->
      $(win).resize =>
        @onWinResize()

      @$doc.on 'PageAdd': (e, page) =>
        @onPageAdd $(page)

    onWinResize: ->
      _ = @
      $imageChaos = $ '.image-chaos'

      $imageChaos.each ->
        $el = $ @
        $items = $el.find '.image-chaos-item'
        _.setLayout $el, $items

    onPageAdd: ($page) ->
      $imageChaos = $page.find '.image-chaos'
      @setup $imageChaos if !!$imageChaos.length

    setup: ($el) ->
      _ = @
      $items = $el.find '.image-chaos-item'

      @setupDrag $items
      @layoutWhenReady $el, $items

      $items.mousedown ->
        _.bringToFront $el, $(this)

    bringToFront: ($el, $item) ->
      $item.appendTo $el

    setupDrag: ($items) ->
      $items.draggable(
        {
          containment: 'document'
          scroll: false
        }
      )

    layoutWhenReady: ($el, $items) ->
      $items.imagesLoaded =>
        @setLayout $el, $items

    setLayout: ($el, $items) ->
      listWidth = $items.parent().width()

      $items.each ->
        $el = $ @

        left = App.Utils.getRandomInt 0, listWidth - $el.width()
        top = App.Utils.getRandomInt 0, 100

        $el.css(
          left: left
          top: top
        )

  win.App.ImageChaos = ImageChaos

)(window, document, jQuery)
