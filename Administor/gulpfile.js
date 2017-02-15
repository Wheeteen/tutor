var gulp = require('gulp');

//引入组件
var less = require('gulp-less'),
    minifycss = require('gulp-minify-css'),
    rename = require('gulp-rename'),
    livereload = require('gulp-livereload'),
    uglify = require('gulp-uglify');
//css
gulp.task('css',function(){
	return gulp.src('src/less/*.less')
	       .pipe(less())
	       .pipe(rename({suffix: '.min'}))
	       .pipe(minifycss())
	       .pipe(gulp.dest('dist/css'));
});

// js
gulp.task('js', function() {
    return gulp.src('src/js/*.js')
        .pipe(rename({ suffix: '.min' }))
        .pipe(uglify())
        .pipe(gulp.dest('dist/js'));
});
gulp.task('watch',function(){
   livereload.listen();
   gulp.watch('src/less/*.less',['css']);
   gulp.watch('src/js/*.js', ['js']);
})