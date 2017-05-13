var captchaNmsp = {
    currentAngleInDegrees : 0.0,
    captchaImagePos : 'undefined',
    startPos : {
        x: 0,
        y: 0
    },
    mouseButtonPressed : false,
    rotationAngle : 0.0,
    halfCaptchaSize : 101,
    myuid : 'undefined',
    show : false,
    arrowsrotate : 0
};

function initCaptcha(nameImg, nameLbl){ // Запускает обработчики мыши и изменят размеры изображения
    captchaNmsp.captchaImagePos = $('#'+nameImg).offset();

    captchaNmsp.currentAngleInDegrees = 0.0;
    captchaNmsp.startPos = {
        x: 0,
        y: 0
    };
    captchaNmsp.mouseButtonPressed = false;
    captchaNmsp.rotationAngle = 0.0;

    $('#'+nameImg).mousedown(function(event){
        console.log(captchaNmsp.captchaImagePos);
        event = event || window.event;
        if (event.preventDefault) {
            event.preventDefault();
        } else {
            event.returnValue = false;
        }

        captchaNmsp.mouseButtonPressed = true;
        captchaNmsp.startPos.x = event.pageX - captchaNmsp.captchaImagePos.left;
        captchaNmsp.startPos.y = event.pageY - captchaNmsp.captchaImagePos.top;
    });

    $('#'+nameImg).mousemove(function(event) {
        if (captchaNmsp.mouseButtonPressed) {
            var a = {
                x : captchaNmsp.startPos.x - captchaNmsp.halfCaptchaSize,
                y : captchaNmsp.halfCaptchaSize - captchaNmsp.startPos.y
            };
            var b = {
                x : (event.pageX - captchaNmsp.captchaImagePos.left) - captchaNmsp.halfCaptchaSize, // Выражение в скобках обозначает ЛОКАЛЬНЫЕ КООРДИНАТЫ МЫШИ
                y : captchaNmsp.halfCaptchaSize - (event.pageY - captchaNmsp.captchaImagePos.top)
            };

            var newangle = Math.acos((a.x * b.x + a.y * b.y) / Math.sqrt((a.x * a.x + a.y * a.y)*(b.x * b.x + b.y * b.y))) * 57.295779513;
            if (a.y * b.x - a.x * b.y < 0) // Надо учитывать знак угла
                newangle = 360.0 - newangle;

            if (captchaNmsp.rotationAngle > 360.0)
                captchaNmsp.rotationAngle -= 360.0;

            if (captchaNmsp.rotationAngle < 0.0)
                captchaNmsp.rotationAngle += 360.0;

            captchaNmsp.currentAngleInDegrees = newangle + captchaNmsp.rotationAngle;
            if (captchaNmsp.currentAngleInDegrees > 360.0) {
                captchaNmsp.currentAngleInDegrees -= 360.0;
            }
            if (captchaNmsp.currentAngleInDegrees < 0.0)
                captchaNmsp.currentAngleInDegrees += 360.0;
            $('#'+nameImg).getRotateAngle();
            jQuery('#'+nameImg).rotate(captchaNmsp.currentAngleInDegrees);
            $('#'+nameLbl).html("<center>∠ = "+ (captchaNmsp.currentAngleInDegrees.toFixed(1)) + "°</center>");
        }
    });

    $('#'+nameImg).mouseup(function(){
        captchaNmsp.mouseButtonPressed = false;
        captchaNmsp.rotationAngle = captchaNmsp.currentAngleInDegrees;

        if (captchaNmsp.rotationAngle > 360.0)
            captchaNmsp.rotationAngle -= 360.0;

        if (captchaNmsp.rotationAngle < 0.0)
            captchaNmsp.rotationAngle += 360.0;
    });

    $('#'+nameImg).mouseover(function(event){
        if (event.which == 2) {

            captchaNmsp.mouseButtonPressed = true;
            captchaNmsp.startPos.x = event.pageX - captchaNmsp.captchaImagePos.left;
            captchaNmsp.startPos.y = event.pageY - captchaNmsp.captchaImagePos.top;
        }
    });

    $('#'+nameImg).mouseout(function(event){
        captchaNmsp.mouseButtonPressed = false;
        captchaNmsp.rotationAngle = captchaNmsp.currentAngleInDegrees;

        if (captchaNmsp.rotationAngle > 360.0)
            captchaNmsp.rotationAngle -= 360.0;

        if (captchaNmsp.rotationAngle < 0.0)
            captchaNmsp.rotationAngle += 360.0;
    });
}

function doNothing(){

}

function deinitCaptcha(nameImg){ // Делает то же, что и init, только наоборот

    delete $('#'+nameImg).mousedown;
    delete $('#'+nameImg).mousemove;
    delete $('#'+nameImg).mouseup;
    delete $('#'+nameImg).mouseover;
    delete $('#'+nameImg).mouseout;
}
