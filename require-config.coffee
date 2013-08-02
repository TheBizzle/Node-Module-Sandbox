requirejs.config({
  baseUrl: "dist",
  paths: {}
  shim: {
    'jqueryui-browser': {
      exports: '$',
      deps: ['jquery']
    },
    'underscore': {
      exports: '_'
    },
    'underscore.string': {
      deps: ['underscore']
    }
  }
});
