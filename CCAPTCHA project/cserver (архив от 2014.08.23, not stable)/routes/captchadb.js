/**
 * Created by elluzion on 22.08.14.
 */

var deltaerror = 6.0;
var activetime = 60000;

var sys = require('sys');
var exec = require('child_process').exec;

function getRandomArbitary(min, max){
    return Math.random() * (max - min) + min;
};

function CaptchaDB(){
    this.serverwork = true;
    db = {};
    this.created = 0;
    this.captchacount = 0;
    this.recognized = 0;
    this.notrecognized = 0;
    this.burned = 0;
    this.reqnotexists = 0;

    this.remove = function(uid){
        if (this.serverwork) {
            if (typeof db[uid] != 'undefined') {
                --this.captchacount;
                ++this.burned;
            }
            delete db[uid];
            exec("rm ./public/" + uid + ".png",
                function (error, stdout, stderr) {
                    console.log(stdout);
                    console.log(stderr);
                });
        }
    };

    this.add = function(uid, cbfunction){
        if (this.serverwork) {
            var originalangle = getRandomArbitary(5, 355);
            ++this.captchacount;
            ++this.created;
            db[uid] = {
                originalangle: originalangle,
                time: new Date().getTime()
            };
            setTimeout(function (uid, parent) {
                if (typeof(db[uid]) != 'undefined') {
                    --(parent.captchacount);
                    ++(parent.burned);
                }
                delete db[uid];
                exec("rm ./public/" + uid + ".png",
                    function (error, stdout, stderr) {
                        console.log(stdout);
                        console.log(stderr);
                    });
            }, activetime, uid, this);
            exec("convert -define jpeg:size=201x201 ./public/sources/p" + Math.round(getRandomArbitary(0, 5)) + ".jpg -thumbnail 201x201^ -gravity center -extent 201x201 ./public/captchas/" + uid + ".png;" +
                    "convert ./public/captchas/" + uid + ".png -matte ./public/sources/mask.png -compose DstIn -composite -background none " +
                    "\\( +clone -background none -rotate -" + Math.round(originalangle) + " \\) -gravity center -compose Src -composite ./public/captchas/" + uid + ".png",
                cbfunction);
        }
    };

    this.check = function(uid, angle){
        if (this.serverwork) {
            if (typeof db[uid] != 'undefined') {
                var curdate = new Date();
                if (curdate.getTime() - db[uid].time < activetime) {                    // Если пользователь успел
                    var wasangle = db[uid].originalangle;
                    this.remove(uid);
                    console.log("ok!");
                    if (Math.abs(angle - wasangle) < deltaerror) {
                        ++this.recognized;
                        return 'CCI_SOLSUCCESS';                                        // Успех
                    } else {
                        ++this.notrecognized;
                        return 'CCI_SOLWRONG';
                    }                                    // Провал
                } else {
                    return 'CCE_TIMEOUT';
                }                                         // Пользователь слоупок
            } else {
                ++this.reqnotexists;
                return 'CCE_DONTEXISTS';
            }                                          // Запрос того, чего нет
            return 'CCE_UNKNOWNERROR';
        }
    };

    this.clean = function(){
        if (this.serverwork) {
            for (key in this.db) {
                delete key;
                /* ... делать что-то с obj[key] ... */
            }

            this.serverwork = false;
            exec("rm -rf ./public/captchas/*.png", function (error, stdout, stderr) {
                console.log(stderr);
            });
            this.created = 0;
            this.captchacount = 0;
            this.recognized = 0;
            this.notrecognized = 0;
            this.burned = 0;
            this.reqnotexists = 0;
            this.serverwork = true;
        }
    }
}
module.exports = CaptchaDB;