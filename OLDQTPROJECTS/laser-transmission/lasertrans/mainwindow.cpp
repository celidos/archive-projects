#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    // -----------------------------------------

    connect(ui->pb_cleartext, SIGNAL(clicked()), this, SLOT(ClearTextMessages()));

    connect(ui->pb_openserial, SIGNAL(clicked()), this, SLOT(StartListening()));
    connect(ui->pb_closeserial, SIGNAL(clicked()), this, SLOT(Disconnect()));
    connect(ui->pb_refreshports, SIGNAL(clicked()), this, SLOT(RefreshPortsList()));

    connect(ui->pb_send1, SIGNAL(clicked()), this, SLOT(SendText1()));

    // -----------------------------------------

    thread_New = new QThread;                   //Создаем поток для порта платы
    PortNew = new Port();                       //Создаем обьект по классу
    PortNew->moveToThread(thread_New);          //помешаем класс  в поток
    PortNew->thisPort.moveToThread(thread_New); //Помещаем сам порт в поток

    connect(PortNew, SIGNAL(error_(QString, bool)), this, SLOT(PrintError(QString, bool))); //Лог ошибок
    connect(thread_New, SIGNAL(started()), PortNew, SLOT(process_Port()));                  //Переназначения метода run
    connect(PortNew, SIGNAL(finished_Port()), thread_New, SLOT(quit()));                    //Переназначение метода выход
    connect(thread_New, SIGNAL(finished()), PortNew, SLOT(deleteLater()));                  //Удалить к чертям поток
    connect(PortNew, SIGNAL(finished_Port()), thread_New, SLOT(deleteLater()));             //Удалить к чертям поток

    connect(this,  SIGNAL(SaveSettings(QString,int,int,int,int,int)),
            PortNew, SLOT(Write_Settings_Port(QString,int,int,int,int,int)));               //Слот - ввод настроек!
    connect(this, SIGNAL(LetsConnect()), PortNew, SLOT(ConnectPort()));
    connect(this, SIGNAL(LetsDisconnect()), PortNew, SLOT(DisconnectPort()));
    connect(PortNew, SIGNAL(outPort(QByteArray)), this, SLOT(ProcessInput(QByteArray)));
    connect(this, SIGNAL(SendBySerial(QByteArray)), PortNew, SLOT(WriteToPort(QByteArray)));

    RefreshPortsList();
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::ClearTextMessages()
{
    ui->te_messages->clear();
    ui->te_messages->setText("[data]");
}

void MainWindow::StartListening()
{
    ui->pb_closeserial->setEnabled(1);
    ui->pb_openserial->setEnabled(0);
    print("Sending params...", "blue");

    QString portName = ui->cb_portname->currentText();

    SaveSettings(portName,              ui->cb_serialspeed->currentText().toInt(),//QSerialPort::Baud9600,
                                        QSerialPort::Data8,
                                        QSerialPort::NoParity,
                                        QSerialPort::OneStop,
                                        QSerialPort::NoFlowControl);
    print("Connecting to " + portName + "...", "blue");
    LetsConnect();
}

void MainWindow::print(QString s, QString color)
{
    ui->te_messages->append("<font color = "+color+">"+s+"<\\font>");
}

void MainWindow::RefreshPortsList()
{
    ui->cb_portname->clear();
    QList <QextPortInfo> ports = QextSerialEnumerator::getPorts();
    foreach (QextPortInfo info, ports) {
        ui->cb_portname->addItem(info.portName);
    }
}

void MainWindow::Disconnect()
{
    emit LetsDisconnect();
    print("Closed", "blue");
    ui->pb_closeserial->setEnabled(0);
    ui->pb_openserial->setEnabled(1);
}

void MainWindow::PrintError(QString err, bool good)
{
    if (good)
        print(err, "blue");
    else
        print(err, "red");
}

void MainWindow::ProcessInput(QByteArray buf)
{
    QString s;
    s = buf[0];
    for (int i = 1; i < buf.size(); ++i)
        s += " " + QString::number(buf[i], 16);
    print(s);
    print(buf);


    if (ui->cb_totext->isChecked())
    {
        s.clear();
        for (int i = 1; i < buf.size(); ++i)
            s += QChar(buf[i]);
        print(QString("{text} = ") + s);
    }
}

void MainWindow::SendText1()
{
    QByteArray buf;
    QString s = ui->le_send1->text();

    QStringList list = s.split(QRegExp("\\s"));

    for (int i = 0; i < list.count(); i++)
    {
        buf.append(list[i].toInt(NULL, 16));
    }
    PortNew->WriteToPort(buf);
}
