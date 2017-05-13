#include "random.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    MyCoolWidget *wgt = new MyCoolWidget;
    QObject::connect(wgt->btn1, SIGNAL(clicked()), wgt, SLOT(Calculate()));
    wgt->resize(800, 600);
    wgt->show();
    return a.exec();
    delete [] wgt;
}

