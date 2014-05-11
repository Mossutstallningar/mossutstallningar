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

    isRetina: ->
      mediaQuery = '(-webkit-min-device-pixel-ratio: 1.5), (min--moz-device-pixel-ratio: 1.5), (-o-min-device-pixel-ratio: 3/2), (min-resolution: 1.5dppx)'
      isRetina = false

      if win.devicePixelRatio > 1
        isRetina = true

      if win.matchMedia && win.matchMedia(mediaQuery).matches
        isRetina = true

      isRetina

  win.App.Utils = Utils

)(window, document, jQuery)
