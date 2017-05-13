/**
 * Created by elluzion on 22.08.14.
 */

var deltaerror = 8.0;
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
    this.denial = 0;

    this.remove = function(uid){
        if (this.serverwork) {
            if (typeof db[uid] != 'undefined') {
                --this.captchacount;
                delete db[uid];
                exec("rm ./public/captchas/" + uid + ".png",
                    function (error, stdout, stderr) {
                        console.log(stdout);
                        console.log(stderr);
                    });
                return true;
            } else {
                return false;
            }
        }
    };

    this.add = function(uid, cbfunction){
        if (this.serverwork) {
            var originalangle = getRandomArbitary(6, 354);
            ++this.captchacount;
            ++this.created;
            db[uid] = {
                originalangle: originalangle,
                time: new Date().getTime()
            };
            setTimeout(function (uid, parent) {
                if (parent.remove(uid)) {
                    ++parent.burned;
                }
            }, activetime, uid, this);
            exec("convert -define jpeg:size=201x201 ./public/sources2/p" + Math.round(getRandomArbitary(0, 11)) + ".jpg -thumbnail 201x201^ -gravity center -extent 201x201 ./public/captchas/" + uid + ".png;" +
                    "convert ./public/captchas/" + uid + ".png -matte ./public/sources2/mask.png -compose DstIn -composite -background none " +
                    "\\( +clone -background none -rotate -" + Math.round(originalangle) + " \\) -gravity center -compose Src -composite ./public/captchas/" + uid + ".png",
                cbfunction);
        }
    };

    this.checkandremove = function(uid, angle){
        var ans = '';
        if (this.serverwork) {
            if (typeof db[uid] != 'undefined') {
                var curdate = new Date();
                if (curdate.getTime() - db[uid].time < activetime) {                    // Если пользователь успел
                    var wasangle = db[uid].originalangle;
                    if (Math.abs(angle - wasangle) < deltaerror) {
                        ++this.recognized;
                        ans =  'CCI_SOLSUCCESS';                                        // Успех
                    } else {
                        ++this.notrecognized;
                        ans =  'CCI_SOLWRONG';
                    }                                    // Провал
                } else {
                    ans = 'CCE_TIMEOUT';
                }
                                                         // Пользователь слоупок
            } else {
                ++this.reqnotexists;
                ans = 'CCE_DONTEXISTS';
            }
            this.remove(uid);
            return ans;
        }
    };

    this.clean = function(){
        if (this.serverwork) {
            db = {};

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
            this.denial = 0;
        }
    }
}
module.exports = CaptchaDB;