module.exports = (grunt) ->

  grunt.initConfig({
    pkg:    grunt.file.readJSON('package.json'),
    coffee: {
      compile: {
        files: [
          {
            expand: true,
            cwd: 'src/coffeescripts',
            src: ['**/*.coffee'],
            dest: 'target/',
            ext: '.js'
          }
        ]
      }
    },
    uglify: {
      options: {
        banner: '/*! <%= pkg.name =%> <%= grunt.template.today("yyyy-mm-dd") =%> */\n'
      },
      build: {
        src:  'target/js/**/*.js',
        dest: 'build/<%= pkg.name =%>.min.js'
      }
    }
  })

  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-requirejs')
  grunt.loadNpmTasks('grunt-contrib-coffee')

  grunt.registerTask('default', ['coffee'])
