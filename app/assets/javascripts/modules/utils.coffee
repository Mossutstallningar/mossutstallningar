((win, doc, $) ->

  Utils =

    getRandomInt: (min, max) ->
      Math.floor(
        Math.random() * (max - min + 1)
      ) + min

  win.App.Utils = Utils

)(window, document, jQuery)
