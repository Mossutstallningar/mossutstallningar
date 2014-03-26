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

    template: (template, data) ->
      template.replace(/\{([\w\.]*)\}/g, (str, key) ->
        keys = key.split('.')
        v = data[keys.shift()]
        v = key for key in keys
        v ? ""
      )

  win.App.Utils = Utils

)(window, document, jQuery)
