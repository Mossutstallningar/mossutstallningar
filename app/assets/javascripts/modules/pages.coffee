((win, doc, $) ->

  Pages =

    init: ->
      @$reset = $ '.page-reset'
      @$pages = $ '.pages'
      @$page = $ '.page'
      @frontZIndex = 0
      @pageCount = @$page.length
      @pages = @getOpenPages()
      @isInitialPopstateEvent = true
      @initialPageState = @getInitialPageState()
      if !!@pageCount
        @setInitialPageState()
        @setTabsFocusTo @$page
      @eventListeners()

    eventListeners: ->
      _ = @

      App.$doc.on 'click', '.internal', (e) ->
        e.preventDefault()
        $el = $ @
        slug = $el.data 'page-slug'
        href = $el.attr 'href'
        if _.pageOpen slug
          _.bringToFront $("##{slug}")
        else
          _.load $el.attr('href')

      App.$doc.on 'submit', '.internal-form', (e) ->
        e.preventDefault()
        $el = $ @
        id = $el.data('page-slug')
        action = $el.attr 'action'
        data = $el.serialize()

        _.close($("##{id}")) if ($("##{id}")).length

        href = "#{action}?#{data}"

        _.load(href)

      App.$doc.on 'click', '.page .close', (e) ->
        e.preventDefault()
        e.stopPropagation()
        _.close $(@).closest('.page')

      App.$doc.on 'mousedown', '.page', ->
        $el = $(@)
        _.bringToFront $el
        _.setTabsFocusTo $el

      App.$win.on 'popstate', (e) ->
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
      App.$doc.trigger 'PageLoad'
      $.ajax
        url: href
        success: (data) =>
          @onAjaxSuccess data, href

        error: (jqXHR, textStatus, errorThrown) ->
          window.location = href

    getOpenPages: ->
      pages = []

      @$page.each ->
        pages.push $(@).attr('id')

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

      @pageCount++
      @reArrangePositions()
      App.$doc.trigger 'PageAdd', $page
      @setTabsFocusTo $page
      @scrollToTop()

    pageOpen: (slug) ->
      !!$("##{slug}").length

    close: ($page) ->
      id = $page.attr 'id'
      @pages.splice $.inArray(id, @pages), 1
      $page.remove()
      if @pages.length
        $newFrontPage = $("##{@pages[@pages.length - 1]}")
        @reArrangePositions()
        @setPageState $newFrontPage.data('state')
        @setTabsFocusTo $newFrontPage
      else
        @setZeroPagesState()
        @reset()
      App.$doc.trigger 'PageClose'

    bringToFront: ($page) ->
      id = $page.attr 'id'
      @pages.splice $.inArray(id, @pages), 1
      @pages.push id
      @setPageState $page.data 'state'
      @reArrangePositions()

    reArrangePositions: ->
      for page, i in @pages
        $("##{page}").css 'zIndex', i+1

    reset: ->
      @$pages.html ''
      @pages = []
      @pageCount = 0
      App.$doc.trigger 'PageClose'

    setZeroPagesState: ->
      # todo: make dynamic
      state =
        title: 'Mossutställningar'
        metaDescription: 'Mossutställningar'
        ogMetaImage: ''
        href: '/'
      @setPageState state
      App.$doc.trigger 'PageZero'

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
      @setMetaDescription state.metaDescription
      @setMetaImage state.ogMetaImage
      @setMetaUrl()
      history.pushState state, state.title, state.href

    setTitle: (title) ->
      doc.title = title

    setMetaDescription: (metaDescription) ->
      metaDescSelector = 'meta[name="description"]'
      ogMetaDescSelector = 'meta[property="og:description"]'

      App.$doc.find(metaDescSelector).attr 'content', metaDescription
      App.$doc.find(ogMetaDescSelector).attr 'content', metaDescription

    setMetaImage: (imageSrc) ->
      ogMetaImageSelector = 'meta[property="og:image"]'

      App.$doc.find(ogMetaImageSelector).attr 'content', imageSrc

    setMetaUrl: ->
      ogMetaUrlSelector = 'meta[property="og:url"]'
      App.$doc.find(ogMetaUrlSelector).attr 'content', win.location.href

    scrollToTop: ->
      $('html, body').scrollTop 0

    setTabsFocusTo: ($page) ->
      prevScrollPos = App.$win.scrollTop()
      $page.focus()
      App.$win.scrollTop prevScrollPos
      App.$doc.trigger 'PageFocus', $page

  win.App.Pages = Pages

)(window, document, jQuery)
