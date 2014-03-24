((win, doc, $) ->
  win.App =
    $win: $ win
    $doc: $ doc
    $body: $ 'body'
)(window, document, jQuery)
