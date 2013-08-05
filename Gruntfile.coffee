module.exports = (grunt) ->

  grunt.initConfig({
    pkg:    grunt.file.readJSON('package.json'),
    coffee: {
      compile: {
        files: [
          {
            expand: true,
            cwd:    'src/coffeescripts',
            src:    ['**/*.coffee'],
            dest:   'target/',
            ext:    '.js'
          }
        ]
      },
      compile_require_config: {
        files: {
          'require-config.js': ['require-config.coffee']
        }
      }
    },
    copy: {
      main: {
        files: [
          {
            expand:  true,
            flatten: true,
            src: [   'node_modules/jquery/lib/node-jquery.js'
                   , 'node_modules/jqueryui-browser/ui/jquery-ui.js'
                   , 'node_modules/underscore/underscore.js'
                   , 'node_modules/underscore.string/lib/underscore.string.js' ],
            dest: 'target/'
          }
        ]
      }
    },
    rename: {
      main: {
        files: [
          { src: 'target/underscore.string.js', dest: 'target/underscore-string.js' },
          { src: 'target/jquery-ui.js',         dest: 'target/jqueryui.js' },
          { src: 'target/node-jquery.js',       dest: 'target/jquery.js' }
        ]
      }
    },
    requirejs: {
      compile: {
        options: {
          baseUrl:        "target/",
          mainConfigFile: "require-config.js",
          out:            "dist/application.js",
          name:           "index/main"
        }
      }
    }
  })

  grunt.loadNpmTasks('grunt-contrib-requirejs')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-rename')

  grunt.registerTask('default', ['coffee', 'copy', 'rename', 'requirejs'])
