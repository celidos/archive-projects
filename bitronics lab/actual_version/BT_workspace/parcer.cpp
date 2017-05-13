#include <QDebug>
#include "parcer.h"

Parcer::Parcer(QObject *parent) : QObject(parent)
{
    //for (char i=1; i != 0; i++)
        //qDebug() << "data" << int(i) << unsigned(i) << unsigned(i)%256 << (int(i) < 0 ? int(i) + 256 : int(i));
}

Parcer::~Parcer()
{
}

int Parcer::parce(QByteArray &data)
{
    int pointsCounter = 0;

    for (int i = 0; i < data.size(); i++) {
        inDataArray.append(data.at(i));
    }

    for (int i=0; i < inDataArray.size()-2; i++) {
        if (inDataArray.at(i) == 'A' && inDataArray.at(i+1) >= '0' && inDataArray.at(i+1) <= '3') {
            i += 2;

            Channel destination;
            double value = double(unsigned(inDataArray.at(i))%256) * 5 / 255;
            //qDebug() << "data" << int(inDataArray.at(i)) << int(inDataArray.at(i));
            switch (inDataArray.at(i-1)) {
            case '0':
                destination = A0;
                break;
            case '1':
                destination = A1;
                break;
            case '2':
                destination = A2;
                break;
            case '3':
                destination = A3;
                break;
            default:
                break;
            }

            emit sign_newDataParced(destination, value);
            pointsCounter++;

            inDataArray.remove(0, i+1);
        }
    }

    emit sign_endOfSession();

    return pointsCounter;
}
