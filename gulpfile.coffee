gulp       = require 'gulp'
plumber    = require 'gulp-plumber'
sass       = require 'gulp-sass'
concat = require 'gulp-concat'
rev        = require 'gulp-rev'
manifest   = require 'gulp-rev-rails-manifest'
source     = require 'vinyl-source-stream'
browserify = require 'browserify'
rimraf = require 'rimraf'

gulp.task 'js', ->
  browserify
    entries: ['./app/assets/javascripts/entry.coffee']
    extensions: ['.coffee']
  .transform 'debowerify'
  .bundle()
  .pipe plumber()
  .pipe source 'app.js'
  .pipe gulp.dest './tmp/assets/javascripts'

gulp.task 'css', ->
  gulp
    .src './app/assets/stylesheets/*.scss'
    .pipe plumber()
    .pipe sass()
    .pipe concat('app.css')
    .pipe gulp.dest './tmp/assets/css'

gulp.task 'rev', ['js', 'css', 'images'], ->
  gulp
    .src ['./tmp/assets/css/*.css', './tmp/assets/javascripts/*.js', './tmp/assets/images/**']
    .pipe rev()
    .pipe gulp.dest './public/assets'
    .pipe manifest()
    .pipe gulp.dest './public/assets'

gulp.task 'images', ->
  gulp
    .src './app/assets/images/*.*'
    .pipe gulp.dest './tmp/assets/images'

gulp.task 'clean', ['rev'] , (callback) ->
  rimraf('./tmp/assets', callback)

gulp.task 'watch', ['build'], ->
  gulp.watch 'app/assets/javascripts/*.coffee', ['js', 'rev']
  gulp.watch 'app/assets/stylesheets/*.scss', ['css', 'rev']
  gulp.watch 'app/assets/images/*.*', ['images', 'rev']

gulp.task 'build', ['js', 'css', 'images', 'rev', 'clean']
gulp.task 'default', ['build']
