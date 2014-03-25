((win, doc, $) ->

  PageDrag =

    init: ->
      @setupDrag $('.page')
      @fixDraggableScrollBug()
      @eventListeners()

    # http://bugs.jqueryui.com/ticket/9315
    # https://forum.jquery.com/topic/jquery-draggable-bug-wrong-offset#14737000004925557
    fixDraggableScrollBug: ->
      safariAgent = /Safari/.test(navigator.userAgent)
      appleVendor = /Apple Computer/.test(navigator.vendor)

      unless safariAgent && appleVendor
        App.$body.draggable()
        App.$body.draggable 'disable'

    eventListeners: ->
      App.$doc.on 'PageAdd': (e, page) =>
        @setupDrag $(page)

      App.$win.on 'debouncedresize', =>
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
      $page.draggable(
        drag: =>
          App.$doc.trigger 'PageDragDrag'
      )
      @disableDrag $page unless @allowDrag()

  win.App.PageDrag = PageDrag

)(window, document, jQuery)
