#ifndef PARCER_H
#define PARCER_H

#include <QObject>
#include <QFile>
#include <QTextStream>
#include "enumeration.h"

typedef double DATA;

/*!
 * \brief The Parcer class
 *
 * Парсит данные по формату ANQ,
 * где  A – A
 *      N – Номер канала
 *      Q – Число с АЦП ардуино
 * и сигналит о том что новые данные получены
 */

class Parcer : public QObject
{
    Q_OBJECT

public:
    Parcer(QObject *parent = 0);
    ~Parcer();

private:
    QString inData;
    QByteArray inDataArray;

signals:
    void sign_newDataParced(Channel, DATA);
    void sign_endOfSession();

public:
    int parce(QByteArray &data);
};

#endif // PARCER_H
