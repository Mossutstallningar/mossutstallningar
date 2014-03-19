((win, doc, $) ->

  Utils =

    getRandomInt: (min, max) ->
      Math.floor(
        Math.random() * (max - min + 1)
      ) + min

    shuffle: (arr) ->
      for i in [arr.length-1..1]
        j = Math.floor Math.random() * (i + 1)
        [arr[i], arr[j]] = [arr[j], arr[i]]

      arr

  win.App.Utils = Utils

)(window, document, jQuery)
