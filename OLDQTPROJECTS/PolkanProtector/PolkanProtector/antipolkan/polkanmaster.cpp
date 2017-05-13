#include "polkanmaster.h"

#define DOOR_SENSOR_POLL_TIME_INTERVAL 5000

PolkanMaster::PolkanMaster(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    // кнопка очищает текстовое поле
    QObject::connect(ui->pb_ClearTextMessages, SIGNAL(clicked()), this, SLOT(clearTextMessages()));

    // устанавливает красивый логотип
    setWindowIcon(QIcon("pp_logo.png"));

    // этот таймер отвечает за обновление времени на форме
    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(refreshTimeOnTimelabel()));
    timer->start(1000);

    // удобно отправлять команды по нажатию Enter
    connect(ui->le_commandline, SIGNAL(returnPressed()), this, SLOT(sendRequest()));

    connect(ui->cb_TimeFiltering, SIGNAL(clicked(bool)), this, SLOT(SwitchTimeFiltering(bool)));
    connect(ui->pb_TestNotify, SIGNAL(clicked()), this, SLOT(TestNotify()));
    connect(ui->pb_TestAlarmDialog, SIGNAL(clicked()), this, SLOT(TestAlarmDialog()));

    connect(this, SIGNAL(Alert(int)), this, SLOT(DoSomeAlert(int))); // КЛЮЧЕВОЙ СИГНАЛ-СЛОТ

    // ---------------------------------------------------------------------------------

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
    connect(PortNew, SIGNAL(outPort(QString)), this, SLOT(ProcessInput(QString)));          //Лог ответа

    door1 = false;
    door2 = false;
    wasinput = false;
    timer1enabled = false;
    timer2enabled = false;

    testmode = false;
    thread_New->start();

    // -------------------------------------

    connect(&client, SIGNAL(connected()), this, SLOT(ClientConnected()));
    connect(&client, SIGNAL(disconnected()), this, SLOT(ClientDisconnected()));
    connect(&client.rosterManager(), SIGNAL(rosterReceived()), this,
                    SLOT(RosterRecieved()));
    connect(&client, SIGNAL(messageReceived(QXmppMessage)), this,
                    SLOT(MessageReceived(QXmppMessage)));
}

void PolkanMaster::ClientConnected()
{
    indicateClient(1);
    print("Сервер подключен", "blue");
}

void PolkanMaster::ClientDisconnected()
{
    indicateClient(0);
    print("Сервер не работает!", "red");
}

void PolkanMaster::indicateClient(int x, QString s)
{
    switch (x)
    {
        case 0:
            ui->lb_server->setText("<html><head/><body><p>Сервер: <span style\
                                    ="" color:#ff0000;"">не подключены</span></p></body></html>");
            break;
        case 1:
            ui->lb_server->setText("<html><head/><body><p>Сервер: <span style\
                                    ="" color:#00cc00;"">работает</span></p></body></html>");
            break;
        case 2:
            ui->lb_server->setText("<html><head/><body><p>Сервер: <span style\
                                    ="" color:#ff0000;"">ош.: "+s+" </span></p></body></html>");
            break;
    }
}

void PolkanMaster::indicateSensors(int x, QString s)
{
    switch (x)
    {
        case 0:
            ui->lb_sensors->setText("<html><head/><body><p>Датчики: <span style\
                                    ="" color:#ff0000;"">не подключены</span></p></body></html>");
            break;
        case 1:
            ui->lb_sensors->setText("<html><head/><body><p>Датчики: <span style\
                                    ="" color:#00cc00;"">подкл. к "+s+"</span></p></body></html>");
        default:
            ui->lb_sensors->setText("<html><head/><body><p>Датчики: <span style\
                                    ="" color:#ff0000;"">ошибка сост.</span></p></body></html>");
    }
}

void PolkanMaster::printUserMessage(QString msg, QString who)
{
    ui->te_messages->append("<font color = gray>"+who+": "+msg+"<\\font>");
}

PolkanMaster::~PolkanMaster()
{
    delete ui;
}

void PolkanMaster::clearTextMessages()
{
    ui->te_messages->clear();
    ui->te_messages->setText(" ~ ~ ~ PP ~ ~ ~ ");
}

void PolkanMaster::refreshTimeOnTimelabel()
{
    QTime curtime = QTime::currentTime();
    ui->lb_time->setText(curtime.toString("hh:mm:ss"));
    ui->lb_date->setText(curtime.toString("dd.mm.yyyy"));
}

void PolkanMaster::sendRequest()
{
    processRequest(ui->le_commandline->text());
    ui->le_commandline->clear();
}

void PolkanMaster::DoSomeAlert(int door)
{
    if (!testmode)
        SendMessageToAllExcept("alarm" + QString::number(door), "", "");
    if (door == 1)
    {
        print(QString::fromStdString(" > Ближняя дверь <"), "red");
        system("notify-send 'Сигнал - Ближняя дверь' 'Кто-то открыл дверь...' --icon='/usr/share/icons/hicolor/48x48/apps/polkan.png'");
    }
    else if (door == 2)
    {
        print(QString::fromStdString(" > Дальняя дверь <"), "red");
        system("notify-send 'Сигнал - Дальняя дверь' 'Кто-то открыл дверь...' --icon='/usr/share/icons/hicolor/48x48/apps/polkan.png'");
    }
    else
    {
        print(QString::fromStdString(" > Какая-то дверь <"), "red");
        system("notify-send 'Сигнал - какая-то дверь' 'Кто-то открыл дверь...' --icon='/usr/share/icons/hicolor/48x48/apps/polkan.png'");
    }
    if (ui->cb_withwindow->checkState() == Qt::Checked)
    {
        AlarmDialog ad;
        ad.setModal(true);
        ad.setWindowFlags(Qt::WindowStaysOnTopHint);
        ad.show();
        ad.exec();
    }
}
void PolkanMaster::TestNotify()
{
    system("notify-send 'Сигнал - xxx дверь' 'Кто-то открыл дверь...' --icon='/usr/share/icons/hicolor/48x48/apps/polkan.png'");
}

void PolkanMaster::TestAlarmDialog()
{
    AlarmDialog ad;
    ad.setModal(true);
    ad.setWindowFlags(Qt::WindowStaysOnTopHint);
    ad.show();
    ad.exec();
}

void PolkanMaster::print(QString s, QString color)
{
    ui->te_messages->append("<font color = "+color+">"+s+"<\\font>");
}

void PolkanMaster::StartListening(QString portName)
{
    print("Отправляем параметры...");
    SaveSettings(portName,              QSerialPort::Baud9600,
                                        QSerialPort::Data8,
                                        QSerialPort::NoParity,
                                        QSerialPort::OneStop,
                                        QSerialPort::NoFlowControl);
    print("Пытаемся соединениться с " + portName + "...");
    LetsConnect();
    lastport = portName;
}

void PolkanMaster::processRequest(QString req)
{
    stringstream str(req.toStdString());
    string s;
    str >> s;

    // Если что-то было сказано
    if (req[0] == '!')
    {
        req[0] = ' ';
        printUserMessage(req);
        SendMessageToAllExcept(req, "~pp~[bot]", "");
        return;
    }

    print(QString::fromStdString("Eddie> ")+req, "#555555");          // выведем на экран нашу команду

    if (s == "cls")
    {
        clearTextMessages();
    }
    else if (s == "sp")
    {
        QList <QextPortInfo> ports = QextSerialEnumerator::getPorts();
        foreach (QextPortInfo info, ports) {
            print(QString("port name: "+ info.portName));
            print("friendly name: "   + info.friendName);
            print("physical name: "   + info.physName);
            print("enumerator name: " + info.enumName);
            print("vendor ID: "       + QString::number(info.vendorID));
            print("product ID: "      + QString::number(info.productID));

            print("===================================");
        }
    }
    else if (s == "qs")
    {
        bool found = false;
        QList <QextPortInfo> ports = QextSerialEnumerator::getPorts();
        foreach (QextPortInfo info, ports) {
            if (info.portName.toStdString().find("USB", 0) != -1)
            {
                print(QString::fromStdString("Среди портов найден ") + info.portName +
                      QString::fromStdString(", подключаемся к нему..."), "blue");
                found = true;
                StartListening(info.portName);
                break;
            }
        }
        if (!found)
            print("Не найдены USB-устройства, проверьте целостность подключения", "red");
    }
    else if (s == "listen")
    {
        str >> s;
        StartListening(QString::fromStdString(s));
    }
    else if (s == "xall")
    {
        wasinput = false;
        door1 = false;
        door2 = false;

        emit LetsDisconnect();
        print("Все отключено", "blue");

        indicateSensors(0);
    }
    else if (s == "falert")
    {
        int a;
        str >> a;
        emit Alert(a);
    }
    else if (s == "login")
    {
        client.logger()->setLoggingType(QXmppLogger::StdoutLogging);
        client.connectToServer("~pp~[bot]@xmpp.ru", "#include<iostream>");
    }
    else if (s == "logout")
    {
        client.disconnectFromServer();
    }
    else if (s == "testmode")
    {
        testmode = !testmode;
        SendMessageToAllExcept("tmode" + QString::number(testmode), "", "");
        if (testmode)
            ui->lb_testmode->setText("test mode!");
        else
            ui->lb_testmode->setText("");
    }

    // INSERT YOUR NEW FUNCTIONS HERE


    else
    {
        print("Неизвестная команда");
    }
}

void PolkanMaster::PrintError(QString err, bool good)
{
    if (good)
        print(err, "blue");
    else
    {
        print(err, "red");
        indicateSensors(0);
    }
}

void PolkanMaster::ProcessInput(QString input)
{
    // timerenabled = true;
    // QTimer::singleShot(200, this, SLOT(updateCaption()));

    if (!wasinput)
    {
        indicateSensors(1, lastport);
        wasinput = true;
    }
    char inp = input[0].toLatin1();
    //qDebug() << inp << endl;
    inp -= '0';
    bool newdoor1 = inp & 1;
    bool newdoor2 = inp & 2;

    if (door1 != newdoor1 && !timer1enabled)
    {
        if (newdoor1 > door1)
        {
            if (timeFiltering)
            {
                timer1enabled = true;
                QTimer::singleShot(DOOR_SENSOR_POLL_TIME_INTERVAL, this, SLOT(AllowRecieving1()));
            }
            emit Alert(1);
        }
    }
    if (door2 != newdoor2 && !timer2enabled)
    {
        if (newdoor2 > door2)
        {
            if (timeFiltering)
            {
                timer2enabled = true;
                QTimer::singleShot(DOOR_SENSOR_POLL_TIME_INTERVAL, this, SLOT(AllowRecieving2()));
            }
            emit Alert(2);
        }
    }
    door1 = newdoor1;
    door2 = newdoor2;
}

void PolkanMaster::SwitchTimeFiltering(bool newvalue)
{
    timeFiltering = newvalue;
}

void PolkanMaster::AllowRecieving1()
{
    timer1enabled = false;
}

void PolkanMaster::AllowRecieving2()
{
    timer2enabled = false;
}

void PolkanMaster::RosterRecieved()
{
    print("Получен список клиентов");
    foreach (const QString &bareJid, client.rosterManager().getRosterBareJids()) {
        QString name = client.rosterManager().getRosterEntry(bareJid).name();
        if(name.isEmpty())
            name = "-";
        print(QString::fromStdString("Клиент: ") + bareJid +
              QString::fromStdString(" (ник ") + name + QString::fromStdString(")"));
    }
}

void PolkanMaster::SendMessageToAllExcept(QString msg, QString who, QString exc)
{
    foreach (const QString &bareJid, client.rosterManager().getRosterBareJids()) {
        if (bareJid != exc)
        {
            client.sendPacket(QXmppMessage("", bareJid, who + msg));
        }
    }
}

void PolkanMaster::MessageReceived(const QXmppMessage& msg)
{
     QString m = msg.body();
    if (m.isEmpty())
        return;

    if (m[0] == '!')
    {
        printUserMessage(m.section('!', 1), msg.from());
        SendMessageToAllExcept(m, msg.from() + ": ", msg.from());
    }
    else
    {
        if (m == "a!" || m == "A!")
        {
            emit Alert(3);
        }
    }
}

//#include "moc_PolkanMaster.cpp" // без этого не работает
