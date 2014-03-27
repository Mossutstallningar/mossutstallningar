((win) ->

  Templates =

    image:
      '<img src="{src}" alt="{alt}" class="{class}" crossorigin="anonymous">'

    gallery:
      '<div ' +
        'class="gallery" ' +
        'data-image-index="0" ' +
        'data-images="{images}" ' +
        'data-image-credits="{imageCredits}" ' +
      '>' +
        '<div class="gallery-inner">' +
          '<button class="button gallery-next">' +
            '<i class="fa fa-chevron-right"></i>' +
            '<span class="button-text">Nästa</span>' +
          '</button>' +
          '<div class="gallery-image-wrapper"></div>' +
          '<span class="gallery-image-credit"></span>' +
        '</div>' +
      '</div>'

  win.App.Templates = Templates

)(window)
