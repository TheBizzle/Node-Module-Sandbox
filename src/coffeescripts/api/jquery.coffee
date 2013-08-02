require.config({
  paths: {
    'jquery':    '/assets/javascripts/managed/jquery-1.9.0.min',
    'jquery-ui': '/assets/javascripts/managed/jquery-ui-1.9.2.custom.min'
  },
  shim: {
    'jquery-ui': {
      exports: '$',
      deps: ['jquery']
    }
  }
})

define(['jquery-ui'], ($) ->

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
