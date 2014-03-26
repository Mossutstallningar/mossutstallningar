((win) ->

  Templates =

    image:
      '<img src="{src}" alt="{alt}" class="{class}">'

    gallery:
      '<div class="gallery" data-image-index="0" data-images="{images}">' +
        '<div class="gallery-inner">' +
          '<button class="button gallery-next">' +
            '<i class="fa fa-chevron-right"></i>' +
            '<span class="button-text">Nästa</span>' +
          '</button>' +
          '<div class="gallery-image-wrapper"></div>' +
        '</div>' +
      '</div>'

  win.App.Templates = Templates

)(window)
