#include "graphicsinspector.h"

QImage* GraphicsInspector::Get(unsigned int index)
{
    if (index < imagescount)
        return &image[index];
    else
        throw "Error";
}

void GraphicsInspector::LoadGraphics(QString &path)
{
    std::cout<< "OK!" << std::endl;
    image = new QImage [imagescount];
    image[0] = QImage(path + "about.bmp");
    image[1] = QImage(path + "bonuswin.bmp");
    image[2] = QImage(path + "border.bmp");
    image[3] = QImage(path + "border-h.bmp");
    image[4] = QImage(path + "border-v.bmp");
    image[5] = QImage(path + "cap.bmp");
    image[6] = QImage(path + "cap_uni.bmp");
    image[7] = QImage(path + "cng!_1.bmp");
    image[8] = QImage(path + "cng!_1p.bmp");
    image[9] = QImage(path + "copy.bmp");
    image[10] = QImage(path + "edit_opt.bmp");
    image[11] = QImage(path + "edit_op2.bmp");
    image[12] = QImage(path + "epanbgr.bmp");
    image[13] = QImage(path + "errorwin.bmp");
    image[14] = QImage(path + "erudit.bmp");
    image[15] = QImage(path + "gameover.bmp");
    image[16] = QImage(path + "go!_1.bmp");
    image[17] = QImage(path + "go!_1p.bmp");
    image[18] = QImage(path + "hallfame.bmp");
    image[19] = QImage(path + "hintbut1.bmp");
    image[20] = QImage(path + "hintbut2.bmp");
    image[21] = QImage(path + "i-button.bmp");
    image[22] = QImage(path + "l-button.bmp");
    image[23] = QImage(path + "marker1.bmp");
    image[24] = QImage(path + "menu.png");
    image[25] = QImage(path + "menubutt.bmp");
    image[26] = QImage(path + "newgame.bmp");
    image[27] = QImage(path + "o-button.bmp");
    image[28] = QImage(path + "prevbut1.bmp");
    image[29] = QImage(path + "prevbut2.bmp");
    image[30] = QImage(path + "questwin.bmp");
    image[31] = QImage(path + "savegame.bmp");
    image[32] = QImage(path + "s-button.bmp");
    image[33] = QImage(path + "scrg1.bmp");
    image[34] = QImage(path + "scrg2.bmp");
    image[35] = QImage(path + "scrm1.bmp");
    image[36] = QImage(path + "scrm2.bmp");
    image[37] = QImage(path + "slot7ch1.bmp");
    image[38] = QImage(path + "slot7ch2.bmp");
    image[39] = QImage(path + "spot-0.bmp");
    image[40] = QImage(path + "spot-bk.bmp");
    image[41] = QImage(path + "spot-bl.bmp");
    image[42] = QImage(path + "spot-gr.bmp");
    image[43] = QImage(path + "spot-rd.bmp");
    image[44] = QImage(path + "spot-wt.bmp");
    image[45] = QImage(path + "spot-yl.bmp");
    image[46] = QImage(path + "starflsh.bmp");
    image[47] = QImage(path + "startwin.bmp");
    image[48] = QImage(path + "test.bmp");
    image[49] = QImage(path + "timet1.bmp");
    std::cout<< "OK!" << std::endl;
    //image[] = QImage(path + ".bmp");
    // При добавлении сюда элементов не забудь увеличить imagescount!
}
