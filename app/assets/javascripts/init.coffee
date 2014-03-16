$ =>
  App.Pages.init() if Modernizr.history
  App.NavigationLines.init() if Modernizr.canvas
  App.Search.init()
  App.DynamicFontSize.init()
  App.PageDrag.init()
