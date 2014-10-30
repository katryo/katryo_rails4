gulp       = require 'gulp'
rename     = require 'gulp-rename'
plumber    = require 'gulp-plumber'
concat     = require 'gulp-concat'
sass       = require 'gulp-sass'
bowerFiles = require "gulp-bower-files"
source     = require 'vinyl-source-stream'
browserify = require 'browserify'

gulp.task 'js', ->
  browserify
    entries: ['./app/assets/javascripts/app.coffee']
    extensions: ['.coffee']
  .transform 'debowerify'
  .bundle()
  .pipe plumber()
  .pipe source 'app.js'
  .pipe gulp.dest './public/javascripts'

gulp.task 'vendor', ->
  bowerFiles()
    .pipe plumber()
    .pipe concat('vendor.js')
    #.pipe gulp.dest('./public/javascripts')

gulp.task 'css', ->
  gulp
    .src './app/assets/stylesheets/*.scss'
    .pipe plumber()
    .pipe sass()
    .pipe gulp.dest './public/css'

gulp.task 'images_copy', ->
  gulp
    .src './app/assets/images/**'
    .pipe gulp.dest './public/images'

gulp.task 'watch', ['build'], ->
  gulp.watch 'app/assets/javascripts/*.coffee', ['js']
  gulp.watch 'app/assets/stylesheets/*.scss', ['css']
  gulp.watch 'bower_components/**/*.js', ['vendor']

gulp.task 'build', ['vendor', 'js', 'css', 'images_copy']
gulp.task 'default', ['build']
