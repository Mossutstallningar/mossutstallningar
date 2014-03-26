((win, doc, $) ->

  ImageChaos =

    init: ->
      @els = $ '.image-chaos'

      $imageChaos = $ '.image-chaos'

      @eventListeners()
      @setup $imageChaos if !!$imageChaos.length

    eventListeners: ->
      App.$win.on 'debouncedresize', =>
        @onWinResize()

      App.$doc.on 'PageAdd': (e, page) =>
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
      count = $items.length

      @setupItemEvents $el, $items
      @layoutWhenReady $el, $items

      $items.mousedown ->
        if App.Breakpoints.isMedium && !_.galleryOpen($el)
          _.bringToFront $items, $(@), count

    bringToFront: ($items, $item, count) ->
      $item.data 'image-index', count + 1
      images = []
      imageCredits = []

      $items.sort (a, b) ->
        contentA = $(a).data 'image-index'
        contentB = $(b).data 'image-index'

        if contentA > contentB
          1
        else
          -1

      $items.each (i) ->
        $el = $ @
        $el.css 'zIndex', i + 1
        $el.data 'image-index', i + 1
        images.push $el.data('image-large')
        imageCredits.push $el.data('image-credit')

      $item
        .closest('.image-chaos')
        .data('images', images.reverse().join(','))
        .data('image-credits', imageCredits.reverse().join(','))

    setupItemEvents: ($el, $items) ->
      @setupDrag $items
      @setupClickEvents $el, $items

    setupDrag: ($items) ->
      $items.draggable(
        {
          containment: 'document'
          scroll: false
        }
      )

    setupClickEvents: ($el, $items) ->
      _ = @

      $items.click (e) ->
        unless _.galleryOpen $el
          e.stopPropagation()
          data =
            $el: $el
            $item: $(@)

          App.$doc.trigger 'ImageChaosClick', data

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

    galleryOpen: ($el) ->
      $el.data 'hasInitalizedGallery'

  win.App.ImageChaos = ImageChaos

)(window, document, jQuery)
