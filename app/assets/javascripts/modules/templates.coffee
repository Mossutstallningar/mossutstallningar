((win) ->

  Templates =

    image:
      '<img src="{src}" alt="{alt}" class="{class}" crossorigin="anonymous">'

    imageButtons:
      '<a ' +
        'href="https://www.facebook.com/sharer.php?u={src}&t={credit}" ' +
        'class="button share-facebook" ' +
      '>' +
        '<i class="fa fa-facebook-square"></i>' +
        '<span class="button-text">Dela på Facebook</span>' +
      '</a>' +
      '<a ' +
          'href="http://www.pinterest.com/pin/create/button/' +
          '?url={src}' +
          '&media={src}' +
          '&description={credit}" ' +
          'data-pin-do="buttonPin" ' +
          'data-pin-config="above" ' +
          'class="button share-pinterest" ' +
      '>' +
        '<i class="fa fa-pinterest-square"></i>' +
        '<span class="button-text">Spara på Pinterest</span>' +
      '</a>'

    gallery:
      '<div ' +
        'class="{elClass}" ' +
        'data-image-index="0" ' +
        'data-images="{images}" ' +
        'data-image-credits="{imageCredits}" ' +
      '>' +
        '<div class="gallery-inner">' +
          '<button class="button gallery-prev">' +
            '<i class="fa fa-chevron-left"></i>' +
            '<span class="button-text">Föregående</span>' +
          '</button>' +
          '<button class="button gallery-next">' +
            '<i class="fa fa-chevron-right"></i>' +
            '<span class="button-text">Nästa</span>' +
          '</button>' +
          '<div class="gallery-image-wrapper"></div>' +
          '<span class="gallery-image-credit"></span>' +
        '</div>' +
      '</div>'

    glitch:
      '<div ' +
        'class="glitch-canvas-wrapper" ' +
        'style="width:{wrapperWidth}%;' +
          'padding-bottom:{paddingBottom}%;' +
        '"' +
      '>' +
        '<canvas ' +
          'class="glitch-canvas" ' +
          'width="{width}" ' +
          'height="{height}" ' +
        '>' +
        '</canvas>' +
      '</div>'

  win.App.Templates = Templates

)(window)
