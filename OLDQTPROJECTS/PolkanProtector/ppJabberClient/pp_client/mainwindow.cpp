#include "mainwindow.h"
//#include "form.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    client = new QXmppClient;

    if (!QFile::exists("pass.txt"))
    {
        QMessageBox msgBox;
        msgBox.setText("Не найден файл pass.txt");
        msgBox.exec();
    }
    else
    {

        freopen("pass.txt", "r", stdin);
        string name, password;
        cin >> name >> password;

        client->logger()->setLoggingType(QXmppLogger::StdoutLogging);
        client->connectToServer(QString::fromStdString(name),
                                QString::fromStdString(password));

        //connect(&client, SIGNAL(connected()), this, SLOT(ClientConnected()));
        //connect(&client, SIGNAL(disconnected()), this, SLOT(ClientDisconnected()));
        //connect(client.rosterManager(), SIGNAL(rosterReceived()), this,
        //                SLOT(RosterRecieved()));
        connect(client, SIGNAL(messageReceived(QXmppMessage)), this,
                        SLOT(MessageReceived(QXmppMessage)));
    }

}

void MainWindow::print(QString s, QString color)
{
    ///ui->te_messages->append("<font color = "+color+">"+s+"<\\font>");
}

void MainWindow::DoAlarm(int door)
{
    Form ad;
    ad.setModal(true);
    ad.setWindowFlags(Qt::WindowStaysOnTopHint);
    ad.show();
    ad.exec();
}

void MainWindow::MessageReceived(const QXmppMessage &msg)
{
    QString m = msg.body();

    if (m.isEmpty())
        return;

    if (m[0] == '!')
    {
        m[0] = ' ';
        print(m);
        return;
    }

    if (m == "alarm1")
        DoAlarm(1);
    else if (m == "alarm2")
        DoAlarm(2);

    if (m == "tmode1")
    {
        print("PP перешел в тестовый режим, и временно Вам не будут приходить уведомления.", "red");
    }
    else if (m == "tmode0")
    {
        print("PP снова работает.", "green");
    }
}

void MainWindow::sendRequest()
{
    QString m = ui->le_commandline->text();
    if (m == "a!" || m == "A!")
        client.sendPacket(QXmppMessage("", "~pp~[bot]@xmpp.ru", m));
    else
        client.sendPacket(QXmppMessage("", "~pp~[bot]@xmpp.ru", "!"+m));
}

MainWindow::~MainWindow()
{
    delete ui;
}
