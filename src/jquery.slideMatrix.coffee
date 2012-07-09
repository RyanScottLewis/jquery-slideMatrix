(($, window) ->
  $.fn.extend
    slideMatrix: () ->
      optionsOrArgument = arguments[0]
      
      switch optionsOrArgument
        when 'slideTo'
          if @currentItem.data('index')? # Which is always should
            nextItemSelector = arguments[1]
            
            if nextItemSelector?
              nextItem = $( nextItemSelector )
              
              unless @currentItem[0] == nextItem[0]
                if nextItem.data('index') > @currentItem.data('index') # Slide right
                  startPos = @currentItem.width()
                else # Slide left
                  startPos = -@currentItem.width()
                
                nextItem.css( left: startPos )
                nextItem.show()
                
                @currentItem.animate left: -startPos, 250
                nextItem.animate left: 0, 250, =>
                  @currentItem.hide()
                  @currentItem = nextItem
        
        when 'slideUp'
          if @currentItem.data('up-selector')
            nextItem = $( @currentItem.data('up-selector') )
            
            nextItem.css( top: -@currentItem.height() )
            nextItem.show()
            
            @currentItem.animate top: @currentItem.height(), 250
            nextItem.animate top: 0, 250, =>
              @currentItem.hide()
              @currentItem = nextItem
        
        when 'slideRight'
          if @currentItem.data('right-selector')
            nextItem = $( @currentItem.data('right-selector') )
            
            nextItem.css( left: @currentItem.width() )
            nextItem.show()
            
            @currentItem.animate left: -@currentItem.width(), 250
            nextItem.animate left: 0, 250, =>
              @currentItem.hide()
              @currentItem = nextItem
        
        when 'slideDown'
          if @currentItem.data('down-selector')
            nextItem = $( @currentItem.data('down-selector') )
            
            nextItem.css( top: @currentItem.height() )
            nextItem.show()
            
            @currentItem.animate top: -@currentItem.height(), 250
            nextItem.animate top: 0, 250, =>
              @currentItem.hide()
              @currentItem = nextItem
        
        when 'slideLeft'
          if @currentItem.data('left-selector')
            nextItem = $( @currentItem.data('left-selector') )
            
            nextItem.css( left: -@currentItem.width() )
            nextItem.show()
            
            @currentItem.animate left: @currentItem.width(), 250
            nextItem.animate left: 0, 250, =>
              @currentItem.hide()
              @currentItem = nextItem
        
        else
          @defaultOptions =
            initialItemFilter: ':first'
          
          settings = $.extend( {}, @defaultOptions, optionsOrArgument )
          
          items = @find('.slideMatrixItem')
          initialItem = items.filter( settings.initialItemFilter )
          controls = $( "[data-target='" + @selector + "']" )
          
          controls.click (e) =>
            e.preventDefault()
            
            $control = $( e.target )
            $target = $( $control.data('target') )
            
            @slideMatrix( $control.data('action'), $control.data('selector') )
            
            false
          
          items.hide()
          initialItem.show()
          
          @currentItem = initialItem
          
      @
) jQuery, this
