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
    },
    browserify: {
      compile: {
        src:  'target/**/*.js',
        dest: 'dist/browserified.js'
      }
    }
  })

  grunt.loadNpmTasks('grunt-browserify')
  grunt.loadNpmTasks('grunt-contrib-coffee')

  grunt.registerTask('default', ['coffee', 'browserify'])
