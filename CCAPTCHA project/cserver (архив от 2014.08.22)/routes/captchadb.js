/**
 * Created by elluzion on 22.08.14.
 */

function getUID(len){
    var chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
        out = '';

    for(var i=0, clen=chars.length; i<len; i++){
        out += chars.substr(0|Math.random() * clen, 1);
    }

    // ensure that the uid is unique for this page
    return getUID.uids[out] ? getUID(len) : (getUID.uids[out] = out);
}
getUID.uids = {};

function CaptchaDB(){

    var db = {};

    this.add = function(cbfunction){
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
            cbfunction());
    }

    this.check = function(uid, angle){
        if (new Date().getTime() - db[useruid].time < activetime) {             // Если пользователь успел
            if (Math.abs(angle - db[useruid].originalangle) < deltaerror) {
                console.log("Пользователь решил капчу.");
                return 'CCI_SOLSUCC';
            }
            else return 'CCI_SOLWRONG';
            delete db[uid];
        }
        else return 'CCE_TIMEOUT';                                              // Пользователь слоупок
    }

    this.remove = function(uid){
        delete db[uid];
    }
}