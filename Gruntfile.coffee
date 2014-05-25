module.exports = (grunt) ->

  grunt.initConfig({
    pkg:    grunt.file.readJSON('package.json'),
    less: {
      production: {
        files: {
          "dist/animation.css": "assets/stylesheets/animation.less"
          "dist/index.css":     "assets/stylesheets/index.less"
          "dist/main.css":      "assets/stylesheets/main.less"
        }
      }
    },
    copy: {
      main: {
        files: [
          {
            expand:  true,
            flatten: true,
            src: [   'node_modules/jquery/tmp/jquery.js'
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
          { src: 'target/jquery-ui.js',         dest: 'target/jqueryui.js' }
        ]
      }
    },
    ts: {
      build: {
        src:    ["src/typescripts/**/*.ts"],
        outDir:  'target/',
        watch:   'src/typescripts'
        options: {
          noImplicitAny: true
        }
      }
    }
  })

  grunt.loadNpmTasks('grunt-ts')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-less')
  grunt.loadNpmTasks('grunt-contrib-rename')

  grunt.registerTask('default', ['less', 'copy', 'rename', 'ts'])
