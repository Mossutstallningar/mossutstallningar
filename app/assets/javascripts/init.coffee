$ =>
  App.Breakpoints.init()
  App.Analytics.init() if _gaq?
  App.Pages.init() if Modernizr.history
  App.Search.init()
  App.ImageChaos.init()
  App.Gallery.init()
  App.Overlay.init() if App.options.showOverlay && App.Breakpoints.isMedium
  App.Tooltip.init() unless Modernizr.touch

  if Modernizr.canvas
    App.NavigationLines.init() if App.options.showNavigationLines
    App.Ghost.init() if App.options.showGhost && App.Breakpoints.isMedium
    App.Glitch.init()

  unless ie < 9
    App.DynamicFontSize.init()
    App.PageDrag.init()
    App.PageStyle.init()
    App.Loader.init()

  App.FallbackColumns.init() unless Modernizr.csscolumns

App.$win.load ->
  App.Preload.init()
