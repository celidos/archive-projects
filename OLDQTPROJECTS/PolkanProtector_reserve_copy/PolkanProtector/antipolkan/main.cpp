#include "polkanmaster.h"

#include <QApplication>
#include <QtSerialPort/QtSerialPort> // файл работы с COM-портом

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    PolkanMaster w;

    w.show();
    return a.exec();
}

//#include "moc_main.cpp"
//#include "main.moc"
