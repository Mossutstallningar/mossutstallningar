((win, doc, $) ->

  PageDrag =

    init: ->
      @$doc = $ doc
      @setupDrag $('.page')
      @fixDraggableScrollBug()
      @eventListeners()

    # http://bugs.jqueryui.com/ticket/9315
    # https://forum.jquery.com/topic/jquery-draggable-bug-wrong-offset#14737000004925557
    fixDraggableScrollBug: ->
      $('body').draggable(
        drag: ->
          false
      )

    eventListeners: ->
      @$doc.on 'PageAdd': (e, page) =>
        @setupDrag $(page)

      $(win).on 'debouncedresize', =>
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
