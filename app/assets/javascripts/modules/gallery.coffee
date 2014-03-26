((win, doc, $) ->

  Gallery =

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
        $image = $imageWrapper.find '.gallery-image-image'

        _.positionImage $gallery, $imageWrapper, $image

    setup: ($el) ->
      galleryHTML =
        '<div class="gallery" data-image-index="0" data-images="' + $el.data('images') + '">' +
        '<button class="gallery-next">Next</button>' +
        '<div class="gallery-image-wrapper"></div>' +
        '</div>'

      $el.append galleryHTML
      $el.data 'hasInitalized', true

      @setupNextButton $el.find('.gallery')

    display: ($gallery, $item) ->
      $imageWrapper = $gallery.find '.gallery-image-wrapper'
      $imageWrapper.css 'visibility', 'none'
      $imageWrapper.html '<img src="' + $item.data('image-large') + '" alt="" class="gallery-image-image">'

      $image = $imageWrapper.find '.gallery-image-image'

      $image.imagesLoaded =>
        @positionImage $gallery, $imageWrapper, $image

      @hasOpenImage = true

    changeImage: ($gallery, newSrc) ->
      console.log 'newSrc', newSrc
      $image = $gallery.find '.gallery-image-image'
      $image.attr 'src', newSrc

    positionImage: ($gallery, $imageWrapper, $image) ->
      galleryWidth = $gallery.width()
      windowWidth = App.$win.width()
      imageWidth = $image.width()
      windowMargin = 40

      if imageWidth > (windowWidth - windowMargin)
        $image.width(windowWidth - windowMargin)
        imageWidth = $image.width()


      $imageWrapper.css(
        left: (galleryWidth - imageWidth) / 2
        visibility: 'visible'
      )

    hasInitalized: ($el) ->
      !!$el.data 'hasInitalized'

    setupNextButton: ($gallery) ->
      $button = $gallery.find '.gallery-next'
      images = $gallery.data('images').split(',')
      console.log images

      $button.click =>
        index = $gallery.data('image-index') + 1

        unless images[index]
          index = 0

        $gallery.data 'image-index', index
        @changeImage $gallery, images[index]



  win.App.Gallery = Gallery

)(window, document, jQuery)
