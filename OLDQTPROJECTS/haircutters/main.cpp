#include "haircutters.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    HairCutters w;
    w.show();

    return a.exec();
}
