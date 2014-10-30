gulp       = require 'gulp'
plumber    = require 'gulp-plumber'
sass       = require 'gulp-sass'
concat = require 'gulp-concat'
buffer = require 'gulp-buffer'
rev        = require 'gulp-rev'
manifest   = require 'gulp-rev-rails-manifest'
source     = require 'vinyl-source-stream'
browserify = require 'browserify'

gulp.task 'js', ->
  browserify
    entries: ['./app/assets/javascripts/entry.coffee']
    extensions: ['.coffee']
  .transform 'debowerify'
  .bundle()
  .pipe plumber()
  .pipe source 'app.js'
  .pipe buffer()
  .pipe rev()
  .pipe gulp.dest './public/assets'
  .pipe manifest()
  .pipe gulp.dest './public/assets'

gulp.task 'css', ->
  gulp
    .src './app/assets/stylesheets/*.scss'
    .pipe plumber()
    .pipe sass()
    .pipe concat('app.css')
    .pipe buffer()
    .pipe rev()
    .pipe gulp.dest './public/assets'
    .pipe manifest()
    .pipe gulp.dest './public/assets'


gulp.task 'images', ->
  gulp
    .src './app/assets/images/**'
    .pipe gulp.dest './public/images'

gulp.task 'watch', ['build'], ->
  gulp.watch 'app/assets/javascripts/*.coffee', ['js']
  gulp.watch 'app/assets/stylesheets/*.scss', ['css']

gulp.task 'build', ['js', 'css', 'images']
gulp.task 'default', ['build']
