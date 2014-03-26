((win) ->

  Templates =

    image:
      '<img src="{src}" alt="{alt}" class="{class}">'

    gallery:
      '<div class="gallery" data-image-index="0" data-images="{images}">' +
      '<button class="gallery-next">Next</button>' +
      '<div class="gallery-image-wrapper"></div>' +
      '</div>'

  win.App.Templates = Templates

)(window)
