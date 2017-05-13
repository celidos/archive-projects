var express = require('express');
var router = express.Router();
var app = require('../app.js');
var pdb = require('../app.js');
//var serverstarttime = require('../app.js');

var CaptchaDB = require('./captchadb.js');

function getUID(len){
    var chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
        out = '';
    for(var i = 0, clen = chars.length; i < len; i++){
        out += chars.substr(0 | Math.random() * clen, 1);
    }
    return getUID.uids[out] ? getUID(len) : (getUID.uids[out] = out);
}
getUID.uids = {};

var db = new CaptchaDB();

router.get('/', function(req, res) {
    res.render('index', { title: 'Express' });
    console.log("Мы получили запрос на главную страницу");
});

router.get('/captcha', function(req, res) {
    var action = req.query.action;
    if (action == 'get') {
        var uid = getUID(24);
        console.log("Запрос ololololo");
        db.add(uid, function (error, stdout, stderr) {
            console.log(stdout);
            console.log(stderr);
            var ccapcthastruct = {
                time: new Date().getTime(),
                uid: uid
            };
            res.set('Content-Type', 'json');
            res.send(JSON.stringify(ccapcthastruct));
            console.log("Сервер отправляет ответ: '%s'", JSON.stringify(ccapcthastruct));
        });
    } else if (action == 'try') {
        console.log("Перенаправляем на главную страницу...");
        res.redirect("/ccaptcha.html");
    } else if (action == 'check') {
        var result = db.checkandremove(req.query.uid, req.query.angle);      // Здесь сама проверка
        res.set('Content-Type', 'json');
        res.send(JSON.stringify({result : result}));                         // Выпиливание капчи
        console.log("Отправлен ответ : " + result);
    } else if (action == 'info') {
        res.set('Content-Type', 'json');
        res.send(JSON.stringify({   cr : db.created,
                                    cc : db.captchacount,
                                    re : db.recognized,
                                    nr : db.notrecognized,
                                    bu : db.burned,
                                    ne : db.reqnotexists,
                                    de : db.denial,
                                    sst : app.serverstarttime
                                }));
    } else if (action == 'cleanserver') {
        res.set('Content-Type', 'json');
        console.log(req.query.password);
        db.clean();
        if (req.query.password == "zololo!@#"){
            res.send(JSON.stringify({ answer : "Ok, done." }));
        } else {
            res.send(JSON.stringify({ answer : "Bad password" }));
        }
    } else if (action == 'denial') {
        console.log("Отказ от запроса : " + req.query.uid);
        if (db.remove(req.query.uid))
            ++db.denial;
        res.send("Ok.");
    } else if (action == 'getimagedatabase') {
        res.set('Content-Type', 'json');
        console.log(app.pdb);
        res.send(JSON.stringify(app.pdb.picturedb));
    }
    else {
        res.send("Неизвестная команда");
    }
});

module.exports = router;