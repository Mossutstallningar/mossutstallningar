((win, doc, $) ->

  Pages =

    init: ->
      @$doc = $ doc
      @$reset = $ '.page-reset'
      @$loader = $ '.loader'
      @$pages = $ '.pages'
      @frontZIndex = 0
      @pageCount = $('.page').length
      @pages = @getOpenPages()
      @isInitialPopstateEvent = true
      @initialPageState = @getInitialPageState()
      @setInitialPageState() if !!@pageCount
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

      @$doc.on 'submit', '.internal-form', (e) ->
        e.preventDefault()
        $this = $ this
        id = $this.data('page-slug')
        action = $this.attr 'action'
        data = $this.serialize()

        _.close($("##{id}")) if ($("##{id}")).length

        href = "#{action}?#{data}"

        _.load(href)

      @$doc.on 'click', '.page .close', (e) ->
        e.preventDefault()
        e.stopPropagation()
        _.close $(this).closest('.page')

      @$doc.on 'click', '.page', () ->
        _.bringToFront $(this)

      $(win).on 'popstate', (e) ->
        if !_.isInitialPopstateEvent
          if _.pages.length
            _.close $("##{_.pages[_.pages.length - 1]}")
          else
            _.load win.location.href
        _.isInitialPopstateEvent = false

      @$reset.click (e) ->
        e.preventDefault()
        _.setZeroPagesState()
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
      id = $page.attr 'id'

      state = @getPageState $html
      state.href = href

      $page.addClass("page-#{@pageCount}").data 'state', state

      @$pages.append $page
      @pages.push id

      @setPageState state

      @scrollToTop()
      @pageCount++
      @reArrangePositions()
      @$doc.trigger 'PageAdd', $page

    pageOpen: (slug) ->
      !!$("##{slug}").length

    close: ($page) ->
      id = $page.attr 'id'
      @pages.splice $.inArray(id, @pages), 1
      $page.remove()
      if @pages.length
        @reArrangePositions()
        @setPageState $("##{@pages[@pages.length - 1]}").data('state')
      else
        @setZeroPagesState()
        @reset()

    bringToFront: ($page) ->
      id = $page.attr 'id'
      @pages.splice $.inArray(id, @pages), 1
      @pages.push id
      @setPageState $page.data 'state'
      @reArrangePositions()

    reArrangePositions: ->
      for page, i in @pages
        $("##{page}").css 'zIndex', i

    reset: ->
      @$pages.html ''
      @pages = []
      @pageCount = 0

    setZeroPagesState: ->
      # todo: make dynamic
      state =
        title: 'Mossutställningar'
        metaDescription: 'Mossutställningar'
        ogMetaImage: ''
        href: '/'
      @setPageState state

    getInitialPageState: ->
      $html = $ 'html'
      state = @getPageState $html
      state.href = win.location.pathname

      state

    setInitialPageState: ->
      $html = $ 'html'
      $page = $ '.page'

      state = @getInitialPageState $html

      $page.data 'state', state

    getPageState: ($html) ->
      state =
        title: $html.find('title').text()
        metaDescription: $html.find('meta[name="description"]').attr 'content'
        ogMetaImage: $html.find('meta[property="og:image"]').attr 'content'

    setPageState: (state) ->
      @setTitle state.title
      @setMetaDescription state.stateDescription
      @setMetaImage state.ogMetaImage
      @setMetaUrl()
      history.pushState state, state.title, state.href

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

  win.App.Pages = Pages

)(window, document, jQuery)
