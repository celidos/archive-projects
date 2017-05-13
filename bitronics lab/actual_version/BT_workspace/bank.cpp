#include "enumeration.h"
#include "bank.h"
#include "qcustomplot.h"

DataBank::DataBank(QObject *parent):QObject(parent)
{}

const QVector<DATA>* DataBank::getXArr(Channel channel) const
{
    return dataKeepers[static_cast<int>(channel)].getXArr();
}

const QVector<DATA>* DataBank::getYArr(Channel channel) const
{
    return dataKeepers[static_cast<int>(channel)].getYArr();
}

void DataBank::slot_receiveNewData(Channel destination, DATA data)
{
    dataKeepers[static_cast<int>(destination)].addData(data);
}

void DataBank::slot_endOfSession() {
    for (int i=0;i<MAX_Y_ARR;i++)
        dataKeepers[i].updateTime();
}

void DataBank::slot_clear() {
    for (int i=0;i<MAX_Y_ARR;i++)
        dataKeepers[i].clear();
}
