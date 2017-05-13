#include "mainwindow.h"
#include "graphicsinspector.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    QString path("/grafix/classic/");

    GraphicsInspector graphics;
    graphics.LoadGraphics(path);


    return a.exec();
}

