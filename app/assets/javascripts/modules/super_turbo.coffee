((win, doc, $) ->

  SuperTurbo =

    init: ->
      @$doc = $ doc
      @$reset = $ '.page-reset'
      @$loader = $ '.loader'
      @$pages = $ '.pages'
      @frontZIndex = 0
      @pageCount = $('.page').length
      @pages = @getOpenPages()
      @isInitialPopstateEvent = true
      @eventListeners()

    eventListeners: ->
      _ = @

      @$doc.on 'click', '.internal', (e) ->
        e.preventDefault()
        $this = $ this
        slug = $this.data 'page-slug'
        href = $this.attr 'href'
        if _.pageOpen slug
          _.bringToFront $("##{slug}")
        else
          _.load $(this).attr('href')

      @$doc.on 'click', '.page .close', (e) ->
        e.preventDefault()
        e.stopPropagation()
        _.close $(this).closest('.page')

      @$doc.on 'click', '.page', () ->
        _.bringToFront $(this)

      $(win).on 'popstate', (e) ->
        if !_.isInitialPopstateEvent
          _.load win.location.href
        _.isInitialPopstateEvent = false

      @$reset.click (e) ->
        e.preventDefault()
        _.reset()


    load: (href) ->
      @showLoader()
      $.ajax
        url: href
        success: (data) =>
          @onAjaxSuccess data, href
          @hideLoader()

        error: (jqXHR, textStatus, errorThrown) ->
          window.location = href

    getOpenPages: ->
      pages = []

      $('.page').each ->
        pages.push $(this).attr('id')

      pages

    onAjaxSuccess: (data, href) ->
      if @pageCount > 5
        @pageCount = 0

      $html = $('<div>').append($.parseHTML(data))
      $page = $html.find '.page'
      title = $html.find('title').text()
      metaDescription = $html.find('meta[name="description"]').attr 'content'
      ogMetaImage = $html.find('meta[property="og:image"]').attr 'content'
      id = $page.attr 'id'

      state =
        title: title

      history.pushState state, title, href

      $page.addClass("page-#{@pageCount}")

      @$pages.append $page
      @pages.push id
      @setTitle title
      @setMetaDescription metaDescription
      @setMetaImage ogMetaImage
      @setMetaUrl()
      @scrollToTop()
      @pageCount++
      @reArrangePositions()

    pageOpen: (slug) ->
      !!$("##{slug}").length

    close: ($page) ->
      id = $page.attr 'id'
      @pages.splice $.inArray(id, @pages), 1
      $page.remove()
      if @pages.length
        @reArrangePositions()
      else
        @reset()

    bringToFront: ($page) ->
      id = $page.attr 'id'
      @pages.splice $.inArray(id, @pages), 1
      @pages.push id

      @reArrangePositions()

    reArrangePositions: ->
      for page, i in @pages
        $("##{page}").css 'zIndex', i

    reset: ->
      @$pages.html ''
      @pages = []
      @pageCount = 0

    setTitle: (title) ->
      doc.title = title

    setMetaDescription: (metaDescription) ->
      metaDescSelector = 'meta[name="description"]'
      ogMetaDescSelector = 'meta[property="og:description"]'

      @$doc.find(metaDescSelector).attr 'content', metaDescription
      @$doc.find(ogMetaDescSelector).attr 'content', metaDescription

    setMetaImage: (imageSrc) ->
      ogMetaImageSelector = 'meta[property="og:image"]'

      @$doc.find(ogMetaImageSelector).attr 'content', imageSrc

    setMetaUrl: ->
      ogMetaUrlSelector = 'meta[property="og:url"]'
      @$doc.find(ogMetaUrlSelector).attr 'content', win.location.href

    showLoader: ->
      @$loader.addClass 'loader-loading'

    hideLoader: ->
      @$loader.removeClass 'loader-loading'

    scrollToTop: ->
      $('html, body').scrollTop 0

  win.App.SuperTurbo = SuperTurbo

)(window, document, jQuery)
