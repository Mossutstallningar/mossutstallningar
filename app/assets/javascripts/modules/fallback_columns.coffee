((win, doc, $) ->

  FallbackColumns =

    init: ->
      @$sitemap = $ '.sitemap'
      @setup()

    setup: ->
      @$sitemap.columnize(
        columns: 4
      )

  App.FallbackColumns = FallbackColumns

)(window, document, jQuery)
