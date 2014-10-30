gulp       = require 'gulp'
plumber    = require 'gulp-plumber'
sass       = require 'gulp-sass'
concat = require 'gulp-concat'
rev        = require 'gulp-rev'
manifest   = require 'gulp-rev-rails-manifest'
source     = require 'vinyl-source-stream'
browserify = require 'browserify'
rimraf = require 'rimraf'
uglify = require 'gulp-uglify'
buffer = require 'vinyl-buffer'
minifyCSS = require 'gulp-minify-css'

gulp.task 'js', ->
  browserify
    entries: ['./app/assets/javascripts/entry.coffee']
    extensions: ['.coffee']
  .transform 'debowerify'
  .bundle()
  .pipe plumber()
  .pipe source 'app.js'
  .pipe buffer()
  .pipe uglify()
  .pipe gulp.dest './public/javascripts'

gulp.task 'css', ->
  gulp
    .src ['./app/assets/stylesheets/*.scss', './bower_components/bootstrap-sass/dist/css/bootstrap.min.css']
    .pipe plumber()
    .pipe sass()
    .pipe minifyCSS({keepBreaks:false})
    .pipe concat('app.css')
    .pipe gulp.dest './tmp/assets/css'

gulp.task 'rev', ['css', 'clean_before_rev'], ->
  gulp
    .src ['./tmp/assets/css/*.css', './app/assets/images/*']
    .pipe rev()
    .pipe gulp.dest './public/assets'
    .pipe manifest()
    .pipe gulp.dest './public/assets'

gulp.task 'clean_before_rev', (callback) ->
  rimraf('./public/assets', callback)

gulp.task 'clean_after_rev', ['rev'] , (callback) ->
  rimraf('./tmp/assets', callback)

gulp.task 'watch', ['build'], ->
  gulp.watch 'app/assets/javascripts/*.coffee', ['js', 'rev']
  gulp.watch 'app/assets/stylesheets/*.scss', ['css', 'rev']

gulp.task 'build', ['js', 'css', 'rev', 'clean_after_rev']
gulp.task 'default', ['build']
