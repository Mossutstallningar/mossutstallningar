$ =>
  App.Breakpoints.init()
  App.Pages.init() if Modernizr.history
  App.Search.init()
  App.ImageChaos.init()

  if Modernizr.canvas
    App.NavigationLines.init() if App.options.showNavigationLines
    App.Ghost.init() if App.options.showGhost

  unless ie < 9
    App.DynamicFontSize.init()
    App.PageDrag.init()
    App.PageStyle.init()
    App.Loader.init()

  App.FallbackColumns.init() unless Modernizr.csscolumns
