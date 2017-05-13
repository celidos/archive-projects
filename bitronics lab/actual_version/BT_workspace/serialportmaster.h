#ifndef SERIALPORTMASTER_H
#define SERIALPORTMASTER_H

#include <QtSerialPort/QSerialPort>
#include <QDebug>

class SerialPortMaster : public QObject
{
    Q_OBJECT

public:
    SerialPortMaster(QObject *parent = 0);
    ~SerialPortMater();

    QSerialPort *serial;
private:


public slots:

};

#endif // SERIALPORTMASTER_H

