((win, doc, $) ->

  PageStyle =

    init: ->
      @$doc = $ doc
      @eventListeners()

    eventListeners: ->
      @$doc.on 'PageAdd': (e, page) =>
        @onPageAdd $(page)

    onPageAdd: ($page) ->
      @setBorderRadius $page
      @setStartPos $page if App.Breakpoints.isLarge

    setBorderRadius: ($page) ->
      borders = [[], []]

      for i in [0..3]
        borders[0].push "#{App.Utils.getRandomInt(5, 20)}px"

      for i in [0..3]
        borders[1].push "#{App.Utils.getRandomInt(100, 700)}px"

      borders[0] = borders[0].join(' ')
      borders[1] = borders[1].join(' ')

      App.Utils.shuffle borders

      $page.css 'borderRadius', borders.join('/ ')

    setStartPos: ($page) ->
      offset = $page.offset()
      min = -50
      max = 50

      $page.css(
        left: offset.left + App.Utils.getRandomInt(min, max)
        top: offset.top + App.Utils.getRandomInt(min, max)
      )

  win.App.PageStyle = PageStyle

)(window, document, jQuery)
