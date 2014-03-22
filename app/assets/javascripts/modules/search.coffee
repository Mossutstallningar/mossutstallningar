((win, doc, $) ->

  Search =

    init: ->
      @$opener = $ '.search-opener'
      @$form = $ '.search'
      @$query = @$form.find '.search-query'
      @$submit = @$form.find '.search-submit'
      @eventListeners()

    eventListeners: ->
      @$opener
      .click =>
        @open()
      .focus =>
        @open()

      @$query.blur (e) =>
       @onBlur()

    onBlur: ->
      if @$query.val() == ''
        @close()

    open: ->
      @$form
        .removeClass('search-closed')
        .addClass 'search-open'

      @$query.focus()

    close: ->
      @$form
        .removeClass('search-open')
        .addClass 'search-closed'

  App.Search = Search

)(window, document, jQuery)
