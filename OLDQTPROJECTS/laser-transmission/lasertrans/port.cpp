#include "port.h"
#include <qdebug.h>

Port::Port(QObject *parent) :
    QObject(parent)
{
}

Port::~Port()
{
    qDebug("By in Thread!");
    emit finished_Port();
}

void Port :: process_Port(){
    qDebug("Hello World in Thread!");
    connect(&thisPort,SIGNAL(error(QSerialPort::SerialPortError)), this, SLOT(handleError(QSerialPort::SerialPortError)));
    connect(&thisPort, SIGNAL(readyRead()),this,SLOT(ReadInPort()));
}

void Port :: Write_Settings_Port(QString name, int baudrate,int DataBits,
                         int Parity,int StopBits, int FlowControl){
    SettingsPort.name = name;
    SettingsPort.baudRate = (QSerialPort::BaudRate) baudrate;
    SettingsPort.dataBits = (QSerialPort::DataBits) DataBits;
    SettingsPort.parity = (QSerialPort::Parity) Parity;
    SettingsPort.stopBits = (QSerialPort::StopBits) StopBits;
    SettingsPort.flowControl = (QSerialPort::FlowControl) FlowControl;
}

void Port :: ConnectPort(void){//
    thisPort.setPortName(SettingsPort.name);
    if (thisPort.open(QIODevice::ReadWrite)) {
        if (thisPort.setBaudRate(SettingsPort.baudRate)
                && thisPort.setDataBits(SettingsPort.dataBits)//DataBits
                && thisPort.setParity(SettingsPort.parity)
                && thisPort.setStopBits(SettingsPort.stopBits)
                && thisPort.setFlowControl(SettingsPort.flowControl))
        {
            if (thisPort.isOpen()){
                error_((SettingsPort.name+ "Opened !\r").toLocal8Bit(), true);
            }
        } else {
            thisPort.close();
            error_(thisPort.errorString().toLocal8Bit(), false);
          }
    } else {
        thisPort.close();
        error_(thisPort.errorString().toLocal8Bit(), false);
    }
}

void Port::handleError(QSerialPort::SerialPortError error)//
{
    if ( (thisPort.isOpen()) && (error == QSerialPort::ResourceError)) {
        error_(thisPort.errorString().toLocal8Bit(), false);
        DisconnectPort();
    }
}//


void  Port::DisconnectPort(){
    if(thisPort.isOpen()){
        thisPort.close();
        error_(SettingsPort.name.toLocal8Bit() + "Closed !\r", true);
    }
}
//ot tuta kovuratji!!!
void Port :: WriteToPort(QByteArray data){
    if(thisPort.isOpen()){
        thisPort.write(data);
    }
}
//
void Port :: ReadInPort(){
    QByteArray data;

    data.append(thisPort.readAll());

    outPort(data);

    //((QString)(adr.toInt())).toLatin1().toHex()
}

