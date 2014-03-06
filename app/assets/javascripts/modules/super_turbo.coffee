((win, doc, $) ->

  SuperTurbo =

    init: ->
      @$doc = $ doc
      @$loader = $ '.loader'
      @$main = $ '#main'
      @isInitialPopstateEvent = true
      @eventListeners()

    eventListeners: ->
      _ = @

      @$doc.on 'click', '.internal', (e) ->
        e.preventDefault()
        _.load $(this).attr('href')

      $(win).on 'popstate', (e) ->
        if !_.isInitialPopstateEvent
          _.load win.location.href
        _.isInitialPopstateEvent = false

    load: (href) ->
      @showLoader()
      $.ajax
        url: href
        success: (data) =>
          @onAjaxSuccess data, href
          @hideLoader()

        error: (jqXHR, textStatus, errorThrown) ->
          window.location = href

    onAjaxSuccess: (data, href) ->
      $html = $('<div>').append($.parseHTML(data))
      $main = $html.find '#main'
      title = $html.find('title').text()
      metaDescription = $html.find('meta[name="description"]').attr 'content'
      ogMetaImage = $html.find('meta[property="og:image"]').attr 'content'

      state =
        title: title

      history.pushState state, title, href

      @$main.html $main.html()
      @setTitle title
      @setMetaDescription metaDescription
      @setMetaImage ogMetaImage
      @setMetaUrl()
      @scrollToTop()

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
