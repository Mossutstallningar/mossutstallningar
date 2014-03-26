((win, doc, $) ->

  Gallery =

    options:
      width: 1000

    init: ->
      @hasOpenImage = false
      @eventListeners()

    eventListeners: ->
      App.$win.on 'debouncedresize', =>
        @onWinResize()

      App.$doc.on 'ImageChaosClick': (e, data) =>
        @onThumbClick data.$el, data.$item

    onWinResize: ->
      @positionImages() if @hasOpenImage

    onThumbClick: ($el, $item) ->
      @setup $el unless @hasInitalized $el
      @display $el.find('.gallery'), $item

    positionImages: ->
      _ = @

      $('.gallery').each ->
        $gallery = $(@)
        $imageWrapper = $gallery.find '.gallery-image-wrapper'

        _.positionImage $gallery, $imageWrapper

    setup: ($el) ->
      galleryHTML = App.Utils.template(
        App.Templates.gallery,
        {images: $el.data('images')}
      )

      $el.append galleryHTML
      $el.data 'hasInitalized', true

      @setupNextButton $el.find('.gallery')

    display: ($gallery, $item) ->
      image = App.Utils.template(
        App.Templates.image,
        {
          src: $item.data('image-large')
          alt: '',
          class: 'gallery-image-image'
        }
      )
      $imageWrapper = $gallery.find '.gallery-image-wrapper'
      $imageWrapper.css 'visibility', 'none'
      $imageWrapper.html image

      $image = $imageWrapper.find '.gallery-image-image'

      $image.imagesLoaded =>
        @positionImage $gallery, $imageWrapper

      @hasOpenImage = true

    changeImage: ($gallery, newSrc) ->
      $image = $gallery.find '.gallery-image-image'
      $image.attr 'src', newSrc

    positionImage: ($gallery, $imageWrapper) ->
      galleryWidth = $gallery.width()
      windowWidth = App.$win.width()
      windowMargin = 40

      if (windowWidth - windowMargin) < @options.width
        $imageWrapper.width(windowWidth - windowMargin)
      else
        $imageWrapper.width(@options.width)

      $imageWrapper.css(
        left: (galleryWidth - $imageWrapper.width()) / 2
        visibility: 'visible'
      )

    hasInitalized: ($el) ->
      !!$el.data 'hasInitalized'

    setupNextButton: ($gallery) ->
      $button = $gallery.find '.gallery-next'
      images = $gallery.data('images').split(',')

      $button.click =>
        index = $gallery.data('image-index') + 1

        unless images[index]
          index = 0

        $gallery.data 'image-index', index
        @changeImage $gallery, images[index]



  win.App.Gallery = Gallery

)(window, document, jQuery)
