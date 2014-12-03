((win, doc, $) ->

  PageDrag =

    init: ->
      @setupDrag $('.page')
      @eventListeners()

    eventListeners: ->
      App.$doc.on 'PageAdd': (e, data) =>
        @setupDrag data.$page

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
        containment: 'document'
        scroll: false
        drag: =>
          App.$doc.trigger 'PageDragDrag'
      )
      @disableDrag $page unless @allowDrag()

  win.App.PageDrag = PageDrag

)(window, document, jQuery)
