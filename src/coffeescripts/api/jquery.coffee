define(['jqueryui-browser'], ($) ->

  # (String) => jQuery
  $.byID = (id) -> $('#' + id)

  # Selector enhancements
  $.fn.extend({

    # ((Unit) => Unit) => Unit
    unfocus: (f) -> this.blur.apply(this, arguments)

    # (Unit) => String
    outerHTML: ->  $(this).clone().wrap('<div></div>').parent().html()

  })

  $

)

