((win, doc, $) ->

  ImageChaos =

    init: ->
      @els = $ '.image-chaos'

      $imageChaos = $ '.image-chaos'

      @eventListeners()
      @hasDraggable = false
      @setup $imageChaos if !!$imageChaos.length

    eventListeners: ->
      App.$win.on 'debouncedresize', =>
        @onWinResize()

      App.$doc.on 'PageAdd': (e, data) =>
        @onPageAdd data.$page

    onWinResize: ->
      _ = @
      $imageChaos = $ '.image-chaos'

      $imageChaos.each ->
        $el = $ @
        $items = $el.find '.image-chaos-item'

        _.enableOrDisableDrag $items
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
      @enableOrDisableDrag $items

      $items.mousedown ->
        unless _.galleryOpen($el)
          _.bringToFront $items, $(@), count

    enableOrDisableDrag: ($items) ->
      if @allowDrag() && !@hasDraggable
        @enableDrag $items
      else if @hasDraggable && !@allowDrag()
        @disableDrag $items

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
        # since image credits can contain commas, join with tripple pipe
        .data('image-credits', imageCredits.reverse().join('|||'))

    setupItemEvents: ($el, $items) ->
      @setupDrag $items
      @setupClickEvents $el, $items

    enableDrag: ($items) ->
      $items.draggable 'enable'
      @hasDraggable = true

    disableDrag: ($items) ->
      $items
        .removeAttr('style')
        .draggable 'disable'
      @hasDraggable = false

    setupDrag: ($items) ->
      @hasDraggable = true
      $items.draggable(
        {
          containment: 'document'
          scroll: false
        }
      )

    allowDrag: ->
      App.Breakpoints.isMedium

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
