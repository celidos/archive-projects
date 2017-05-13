var express = require('express');
var router = express.Router();
var app = require('../app.js');

var sys = require('sys')
var exec = require('child_process').exec;
var queue = require('./queue.js')

function getRandomArbitary(min, max)
{
    return Math.random() * (max - min) + min;
};

var deltaerror = 6.0;
var activetime = 60000;

var db = {};

router.get('/', function(req, res) {
    res.render('index', { title: 'Express' });
    console.log("Мы получили запрос на главную страницу");
});

router.get('/captcha', function(req, res) {
    console.log("Получен запрос /captcha");

    if (typeof(req.query.action) !== 'undefined')
    {
        console.log("Сервер обрабатывает запрос action=%s", req.query.action);
        var act = req.query.action;
        if (act == "get")
        {
            var uid = getUID(24);
            db[uid] = {
                originalangle: getRandomArbitary(5, 355),
                time: new Date().getTime()
            }
            reqque.enqueue(uid);
            console.log("Сгенерировался угол " + originalangle + " градусов");
            //function (error, stdout, stderr) { sys.puts(stdout); };
            exec("convert -define jpeg:size=201x201 ./public/p"+Math.round(getRandomArbitary(0, 5))+".jpg -thumbnail 201x201^ -gravity center -extent 201x201 ./public/"+uid+".png;" +
                 "convert ./public/"+uid+".png -matte -fill none -draw 'color 0,0 reset' -fill white -draw 'circle 101,101,101,2' ./public/mask.png;"+
                 "convert ./public/"+uid+".png -matte ./public/mask.png -compose DstIn -composite -background none "+
                 "\\( +clone -background none -rotate -"+Math.round(originalangle)+" \\) -gravity center -compose Src -composite ./public/"+uid+".png",
                 function (error, stdout, stderr) {
                     console.log(stdout);
                     console.log(stderr);

                     var ccapcthastruct = {
                         time: new Date().getTime(),
                         file: uid +".png",
                         uid: uid
                     };
                     res.set('Content-Type', 'json');
                     console.log(JSON.stringify(ccapcthastruct));
                     console.log("Сервер отправляет ответ: '%s'", JSON.stringify(ccapcthastruct));
                     res.send(JSON.stringify(ccapcthastruct)); //("kill yourself");
                     console.log("Готово");
                 });
        }
        else if (act == "try")
        {
            console.log("Перенаправляем на главную страницу...");
            res.redirect("/ccaptcha.html");
        }
        else if (act == "check")
        {
            var curtime = new Date().getTime();
            console.log("curtime = " + curtime);
            var angle = req.query.angle;
            var useruid   = req.query.uid;
            console.log("Пользователь '" + useruid + "' думает, что картинку надо повернуть под углом " + angle + " градусов");
            if (curtime - db[useruid].time < activetime) {
                if (Math.abs(angle - db[useruid].originalangle) < deltaerror) {
                    console.log("Пользователь решил капчу.");
                    res.set('Content-Type', 'json');
                    res.send(JSON.stringify({correct: true}));
                    console.log("Готово.");
                }
                else {
                    console.log("Пользователь лох");
                    res.set('Content-Type', 'json');
                    res.send(JSON.stringify({correct: false}));
                    console.log("Готово.");
                }
                delete db[uid];
            }
        }
    }
    else
    {
        console.log("Ошибка: параметр action не определен.");
    }
})

module.exports = router;