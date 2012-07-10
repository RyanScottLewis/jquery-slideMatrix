# jQuery.slideMatrix

An easy multi-dimensional slideshow/carousel.

## Example

    $(function(){
      
      $('#myMatrix').slideMatrix({
        initialItemFilter: '#mainContent',
        slideSpeed: 250
      });
      
    });

Clone and view `example/example.html` for a full example.

## Options

### initialItemFilter

_Default:_ `':first'`

This is the selector of the item elements (slides) within the slideMatrix element.  
See: http://api.jquery.com/filter/

### slideSpeed

_Default:_ `250`

How fast the slideMatrix should slide.

### wraparound

> Not yet implemented.

## License

This content is released under the [MIT License](www.opensource.org/licenses/mit-license.php).  
See the `LICENSE` file for more details.