(($) ->
  class Wysihtml5SizeMatters
    constructor: (iframe, options) ->
      @$iframe = $(iframe)
      @$body = @findBody()

      @addBodyStyles()
      @adjustHeight()
      if options && options.useTimer
        @startInterval()
      else
        @setupEvents()

    # Two styles on the 'body' tag are required to make this
    # autosizing technique work.
    #
    #   'overflow: hidden' keeps out the nasty scroll bar
    #   'min-height: 0' overrides the wysithml5 default of 100%
    addBodyStyles: ->
      @$body.css('overflow', 'hidden');
      @$body.css('min-height', 0);
      @$body.css('height', 'auto');

    setupEvents: ->
      @$body.on 'keyup keydown paste change focus', => @adjustHeight()

    adjustHeight: ->
      @$iframe.css('min-height', @$body.height() + @extraBottomSpacing())

    # This is required to keep the text editor from having a "bouncing" effect.
    # The bouncing effect is a result of difference in time between when a new
    # line is created and the editor's height is re-adjusted.
    extraBottomSpacing: ->
      parseInt(@$body.css('line-height')) || @estimateLineHeight()

    # We have a "normal" line-height, which is usually 1.14x the font size
    estimateLineHeight: ->
      parseInt(@$body.css('font-size')) * 1.14

    findBody: ->
      @$iframe.contents().find('body')

    startInterval: ->
      _this = @
      _this.intervalId = setInterval (() -> _this.adjustHeight()), 250
      _this.intervalId

    stopInterval: ->
      clearInterval @intervalId if @intervalId


  $.fn.wysihtml5_size_matters = (command, options)->
    if command && !options
      options = command

    if command == "stopTimer"
      @each ->
        wysihtml5_size_matters = $.data(@, 'wysihtml5_size_matters')
        if wysihtml5_size_matters
          wysihtml5_size_matters.stopInterval
    else
      @each ->
        wysihtml5_size_matters = $.data(@, 'wysihtml5_size_matters')
        wysihtml5_size_matters = $.data(@, 'wysihtml5_size_matters', new Wysihtml5SizeMatters(@, options)) unless wysihtml5_size_matters
)($)
