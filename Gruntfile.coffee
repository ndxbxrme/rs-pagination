module.exports = (grunt) ->
  require('load-grunt-tasks') grunt
  grunt.initConfig
    watch:
      coffee:
        files: ['src/**/*.coffee']
        tasks: ['build']
    coffee:
      options:
        sourceMap: true
      default:
        files: [{
          expand: true
          cwd: 'src'
          src: ['**/*.coffee']
          dest: 'build'
          ext: '.js'
        }]
    pug:
      options:
        pretty: true
      templates:
        files: [{
          expand: true
          cwd: 'src'
          src: ['**/*.pug']
          dest: 'build'
          ext: '.html'
        }]
    clean:
      build: 'build'
  grunt.registerTask 'build', [
    'clean:build'
    'coffee'
    'pug'
  ]
  grunt.registerTask 'default', [
    'build'
    'watch'
  ]
  grunt.registerTask 'test', [
    'build'
  ]