#include <QDebug>
#include "datakeeper.h"

DataKeeper::DataKeeper():
    pointsCount(0),
    xArr(new QVector<DATA>),
    yArr(new QVector<DATA>),
    timer(new QTime),
    timing(0)
{}

DataKeeper::~DataKeeper()
{
    delete xArr;
    delete yArr;
    delete timer;
}

void DataKeeper::addData(DATA data) {
    pointsCount++;
    if (xArr->isEmpty())
        xArr->push_back(0);
    else
        xArr->push_back(xArr->last()+timing);
    yArr->push_back(data);
}

void DataKeeper::updateTime() {
    if (pointsCount > pointsForTiming) {
        timing = double(timer->restart())/pointsCount/1000;
        pointsCount = 0;
    }

    //qDebug() << "true timing is" << timing;

    if (!xArr->isEmpty() && xArr->last() - xArr->first() > MAX_RANGE*1.5){
        int count=0;
        double edge = xArr->last() - MAX_RANGE;
        for (auto it = xArr->cbegin();it!=xArr->cend();it++) {
            if (*it > edge)
                break;
            count++;
        }
        xArr->remove(0,count);
        yArr->remove(0,count);
    }
}

void DataKeeper::clear()
{
    xArr->clear();
    yArr->clear();

    pointsCount = 0;
    timing = 0;
}
