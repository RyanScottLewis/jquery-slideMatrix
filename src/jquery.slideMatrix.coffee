###
jquery.slideMatrix v0.0.2
(c) 2012 Ryan Lewis <ryanscottlewis@gmail.com> MIT License
###

(($, window) ->
  $.fn.extend
    slideMatrix: ->
      optionsOrArgument = arguments[0]
      
      switch optionsOrArgument
        when 'slideTo'
          argument = arguments[1]
          currentItemPos = @currentItemPos()
          nextPos = {}
          
          if typeof argument == 'string'
            nextElmData = @find( argument ).data()
            nextPos.x = nextElmData.x || 0
            nextPos.y = nextElmData.y || 0
          else if typeof argument == 'object'
            nextPos.x = argument.x || 0
            nextPos.y = argument.y || 0
          else if argument instanceof jQuery
            nextElmData = argument.data()
            nextPos.x = nextElmData.x || 0
            nextPos.y = nextElmData.y || 0
          
          nextItem = @find( ".slideMatrixItem[data-x='" + nextPos.x + "'][data-y='" + nextPos.y + "']" )
          
          if nextItem?
            if nextPos.x > currentItemPos.x
              if nextItem.length == 0 && @settings.wraparound
                console.log 'Should wrap!'
              else
                @slideToItem( nextItem, 'right' )
            else if nextPos.x < currentItemPos.x
              if nextPos.x < 0 && @settings.wraparound
                console.log 'Should wrap!'
              else if nextPos.x >= 0
                @slideToItem( nextItem, 'left' )
            else if nextPos.x == currentItemPos.x
              if nextPos.y > currentItemPos.y
                if nextItem.length == 0 && @settings.wraparound
                  console.log 'Should wrap!'
                else
                  @slideToItem( nextItem, 'up' )
              else if nextPos.y < currentItemPos.y
                if nextPos < 0 && @settings.wraparound
                  console.log 'Should wrap!'
                else
                  @slideToItem( nextItem, 'down' )
        
        when 'slide'
          direction = arguments[1]
          currentItemPos = @currentItemPos()
          
          nextItemPos = switch direction
            when 'up'
              { x: currentItemPos.x, y: currentItemPos.y+1 }
            when 'right'
              { x: currentItemPos.x+1, y: currentItemPos.y }
            when 'down'
              { x: currentItemPos.x, y: currentItemPos.y-1 }
            when 'left'
              { x: currentItemPos.x-1, y: currentItemPos.y }
          
          nextItem = @find( ".slideMatrixItem[data-x='" + nextItemPos.x + "'][data-y='" + nextItemPos.y + "']" )
          if nextItem.length == 0 && @settings.wraparound
            console.log 'Should wrap!'
          else if nextItem.length > 0
            @slideToItem( nextItem, direction )
        
        else
          @defaultOptions =
            initialItemFilter: ':first'
            wraparound: false
            slideSpeed: 250
          
          @settings = $.extend( {}, @defaultOptions, optionsOrArgument )
          
          @currentItemPos = ->
            x: @currentItem.data('x') || 0
            y: @currentItem.data('y') || 0
          
          @sliding = false
          
          @slideToItem = (item, direction) ->
            cssAttr = if direction == 'up' || direction == 'down' then 'top' else 'left'
            
            nextItemCssStartValue = switch direction
              when 'up'    then -@currentItem.height()
              when 'right' then @currentItem.width()
              when 'down'  then @currentItem.height()
              when 'left'  then -@currentItem.width()
            
            nextItemCssStart = (->o={}; o[ cssAttr ] = nextItemCssStartValue; o)()
            nextItemCssEnd = (->o={}; o[ cssAttr ] = 0; o)()
            currentItemCssEnd = (->o={}; o[ cssAttr ] = -nextItemCssStartValue; o)()
            
            item.css( nextItemCssStart )
            item.show()
            
            unless @sliding == true
              @sliding = true
              @currentItem.animate currentItemCssEnd, @settings.slideSpeed
              item.animate nextItemCssEnd, @settings.slideSpeed, =>
                @currentItem.hide().css( left: 0, top: 0 )
                @currentItem = item
                @sliding = false
          
          controls = $( "[data-target='" + @selector + "']" )
          controls.click (e) =>
            e.preventDefault()
            
            unless @sliding == true
              $control = $( e.target )
              $target = $( $control.data('target') )
              action = $control.data('action')
              
              switch action
                when 'slideTo'
                  if $control.data('selector')?
                    @slideMatrix( action, $control.data('selector') )
                  else
                    @slideMatrix( action, { x: $control.data('x'), y: $control.data('y') } )
                when 'slide'
                  @slideMatrix( action, $control.data('direction') || 'right' )
                else
                  return false
              
              false
          
          items = @find('.slideMatrixItem')
          initialItem = items.filter( @settings.initialItemFilter )
          
          
          items.hide()
          initialItem.show()
          
          @currentItem = initialItem
          
      @
) jQuery, this
