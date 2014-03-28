# Create glitched images
# Dependencies:
#   jQuery >= 2.1.0 (http://jquery.com/)
#   imagesLoaded (https://github.com/desandro/imagesloaded)
((win, doc, $, undef) ->

  $.fn.extend

    glitch: ->

      class Glitch

        constructor: ($el) ->
          base64Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

          @$image = $el
          @image = @$image.get 0
          @base64Map = base64Chars.split ''
          @reverseBase64Map = @getReverseBase64Map()
          @imgDataArr = []
          @jpgHeaderLength = null
          @$canvas = null
          @canvas = null
          @ctx = null

          @$image.imagesLoaded =>
            @setupCavnas(@$image.width(), @$image.height())
            @drawOriginalToCanvas()
            @setReadyState()

        setupCavnas: (width, height) ->
          @$image.after(
            '<canvas width="' + width + '" height="' + height + '"></canvas>'
          )
          @$canvas = @$image.next()
          @canvas = @$canvas.get 0
          @ctx = @canvas.getContext '2d'

        drawOriginalToCanvas: ->
          @ctx.drawImage @image, 0, 0

          imgData = @canvas.toDataURL 'image/jpeg'

          @imgDataArr = @base64ToByteArray imgData
          @detectJpegHeaderSize @imgDataArr
          @hideOriginal()
          @draw()

        setReadyState: ->
          @$image.data 'GlitchReady', true

        hideOriginal: ->
          @$image.hide()

        getReverseBase64Map: ->
          map = {}

          @base64Map.forEach (val, key) ->
            map[val] = key

          map

        detectJpegHeaderSize: (data) ->
          for d, i in data
            if d == 0xFF && data[i + 1] == 0xDA
              @jpgHeaderLength = i + 2
              return undef

        # base64 is 2^6, byte is 2^8, every 4 base64 values create three bytes
        base64ToByteArray: (str) ->
          _ = @
          result = []

          for char, i in str
            cur = _.reverseBase64Map[str.charAt(i+23)]

            digitNum = (i) % 4

            switch digitNum
              when 0
                break
                # first digit - do nothing, not enough info to work with
              when 1 # second digit
                result.push prev << 2 | cur >> 4
              when 2 # third digit
                result.push (prev & 0x0f) << 4 | cur >> 2
              when 3 # fourth digit
                result.push (prev & 3) << 6 | cur

            prev = cur

          result

        byteArrayToBase64: (arr) ->
          result = ['data:image/jpeg;base64,']

          for cur, i in arr
            byteNum = i % 3

            switch byteNum
              when 0 # first byte
                result.push @base64Map[cur >> 2]
                break
              when 1 # second byte
                result.push @base64Map[(prev & 3) << 4 | (cur >> 4)]
                break
              when 2 # third byte
                result.push @base64Map[(prev & 0x0f) << 2 | (cur >> 6)]
                result.push @base64Map[cur & 0x3f]
                break

            prev = cur

          if byteNum == 0
            result.push @base64Map[(prev & 3) << 4]
            result.push '=='
          else if byteNum == 1
            result.push @base64Map[(prev & 0x0f) << 2]
            result.push '='

          result.join ''

        glitchJpegBytes: (strArr) ->
          rnd =
            Math.floor(
              @jpgHeaderLength +
              Math.random() *
              (strArr.length - @jpgHeaderLength - 4)
            )

          strArr[rnd] = Math.floor Math.random() * 256

        draw: ->
          glitchCopy = @imgDataArr.slice()

          @glitchJpegBytes glitchCopy

          img = new Image()
          img.src = @byteArrayToBase64 glitchCopy
          $(img).imagesLoaded =>
            @ctx.drawImage img, 0, 0

      @each () ->
        $el = $(@)
        $el.data 'Glitch', new Glitch($el)


)(window, document, jQuery)
