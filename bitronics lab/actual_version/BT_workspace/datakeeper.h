#ifndef DATAKEEPER_H
#define DATAKEEPER_H

#include <QtCore>
#include <QDebug>
#include "qcustomplot.h"
#include "enumeration.h"

class DataKeeper
{
public:
    DataKeeper();
    ~DataKeeper();

    const QVector<DATA> *getXArr() const { return xArr; }
    const QVector<DATA> *getYArr() const { return yArr; }

    void addData(DATA);
    void updateTime();
    void clear();

private:
    static const int pointsForTiming = 200;

    QVector<DATA> *xArr, *yArr;


    QTime *timer;
    int pointsCount;
    double timing;
};

#endif // DATAKEEPER_H
