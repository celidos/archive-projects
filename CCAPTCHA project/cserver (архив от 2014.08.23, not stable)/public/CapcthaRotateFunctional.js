var captchaNmsp = {
    newAngle : 0.0,										<!-- Добавленный к текущему углу новый угол -->
    curangleindegrees : 0.0,
    captchaPos : $('#'+nameImg).offset(),
    StartPos : {
        x: 0,
        y: 0
    },
    pressed : false,
    rotangle : 0.0,
    halfCaptchaSize : 101
}

exports.captchaNmsp = captchaNmsp;

function Initializate(halfcsize, nameImg, nameLbl){
    $('#'+nameImg).mousedown(function(event){
        event = event || window.event
        if (event.preventDefault) {  // если метод существует
            event.preventDefault();
        } else {                     // для IE9
            event.returnValue = false;
        }

        captchaNmsp.pressed = true;
        captchaNmsp.StartPos.x = event.pageX - captchaNmsp.captchaPos.left;
        captchaNmsp.StartPos.y = event.pageY - captchaNmsp.captchaPos.top;
    });

    $('#'+nameImg).mousemove(function(event){
        if (captchaNmsp.pressed){

            var a = {
                x : StartPos.x - HalfCaptchaSize,
                y : HalfCaptchaSize - StartPos.y
            };
            var b = {
                x : (event.pageX - captchaPos.left) - HalfCaptchaSize,  <!-- выражение в скобках обозначает ЛОКАЛЬНЫЕ КООРДИНАТЫ МЫШИ -->
                y : HalfCaptchaSize - (event.pageY - captchaPos.top)
            };

            newangle = Math.acos((a.x * b.x + a.y * b.y) / Math.sqrt((a.x * a.x + a.y * a.y)*(b.x * b.x + b.y * b.y))) * 57.295779513;
            if (a.y * b.x - a.x * b.y < 0)								<!-- Надо учитывать знак угла -->
                newangle = 360 - newangle;

            if (rotangle > 360.0)
                rotangle -= 360.0;

            if (rotangle < 0.0)
                rotangle += 360.0;

            curangleindegrees = newangle + rotangle;
            if (curangleindegrees > 360.0) {
                curangleindegrees -= 360.0;
            }
            if (curangleindegrees < 0.0)
                curangleindegrees += 360.0;
            $('#'+nameImg).getRotateAngle();
            jQuery('#'+nameImg).rotate(curangleindegrees);
            //$('#'+nameImg).css({'transform-origin':'center', WebkitTransform : 'rotate(' + curangleindegrees + 'deg)'});
            //$('#'+nameImg).css({'transform-origin':'center', '-moz-transform': 'rotate(' + curangleindegrees + 'deg)'});
            $('#'+nameLbl).html("<p>Поворот: " + (Math.round(curangleindegrees).toFixed(2)) + " градусов</p>");
        }
    });

    $('#'+nameImg).mouseup(function(){
        pressed = false;
        rotangle = curangleindegrees;

        if (rotangle > 360.0)
            rotangle -= 360.0;

        if (rotangle < 0.0)
            rotangle += 360.0;
    });

    $('#'+nameImg).mouseover(function(event){
        console.log(event.which + "; " + event.button);
        if (event.which == 2) {

            pressed = true;
            StartPos.x = event.pageX - captchaPos.left;
            StartPos.y = event.pageY - captchaPos.top;
        }
    });

    $('#'+nameImg).mouseout(function(event){
        pressed = false;
        rotangle = curangleindegrees;
        newangle = 0;

        if (rotangle > 360.0)
            rotangle -= 360.0;

        if (rotangle < 0.0)
            rotangle += 360.0;
    });

}
