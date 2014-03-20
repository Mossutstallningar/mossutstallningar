$ =>
  App.Breakpoints.init()
  App.Pages.init() if Modernizr.history
  App.NavigationLines.init() if Modernizr.canvas
  App.Search.init()
  App.DynamicFontSize.init()
  App.PageDrag.init()
  App.PageStyle.init()
  App.Loader.init()
  App.ImageChaos.init()
