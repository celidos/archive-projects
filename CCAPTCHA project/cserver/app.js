var express = require('express');
var path = require('path');
var favicon = require('static-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var routes = require('./routes/index');

var PictureDB = require('./public/picturedb.js');

var app = express();
var rootpath = __dirname.toString();
exports.rootpath = rootpath;

var serverstarttime = new Date();
exports.serverstarttime = serverstarttime;

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(favicon());
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded());
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', routes);

/// catch 404 and forward to error handler
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

/// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
    app.use(function(err, req, res, next) {
        res.status(err.status || 500);
        res.render('error', {
            message: err.message,
            error: err
        });
    });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
        message: err.message,
        error: {}
    });
});


module.exports.app = app;
app.listen(6429, function(){
    console.log("CCaptcha-сервер запущен, коренная папка - " + rootpath);
});

var pdb = new PictureDB();
exports.pdb = pdb;
pdb.init();
pdb.searchpictures();
console.log(pdb.picturedb.size + " = size;");
//module.exports.pdb = pdb;


