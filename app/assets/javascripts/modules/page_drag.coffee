((win, doc, $) ->

  PageDrag =

    init: ->
      @$doc = $ doc
      @setupDrag $('.page')
      @eventListeners()

    eventListeners: ->
      @$doc.on 'PageAdd': (e, page) =>
        @setupDrag $(page)

      $(win).resize =>
        $page = $('.page')

        if @allowDrag() && !@hasDraggable
          @enableDrag $page
        else if @hasDraggable && !@allowDrag()
          @disableDrag $page

    allowDrag: ->
      App.Breakpoints.isLarge

    enableDrag: ($el) ->
      $el.draggable 'enable'
      @hasDraggable = true

    disableDrag: ($el) ->
      $el
        .removeAttr('style')
        .draggable 'disable'
      @hasDraggable = false

    setupDrag: ($page) ->
      @hasDraggable = true
      $page.draggable()
      @disableDrag $page unless @allowDrag()

  win.App.PageDrag = PageDrag

)(window, document, jQuery)
