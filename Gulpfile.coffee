gulp = require 'gulp'
mocha = require 'gulp-mocha'

gulp.task 'mocha', ->
  gulp.src 'test/**/*.coffee'
    .pipe mocha
      ui: 'tdd'
