#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QApplication>
#include <QMainWindow>
#include <QtGui>
#include <QDebug>

#include <QLineEdit>
#include <QTextEdit>
#include <QLabel>
#include <QCheckBox>
#include <QTimer>

#include <QString>
#include <QList>
#include <iostream>
#include <sstream>

#include "qextserialenumerator.h"
#include "port.h"

#include "QXmppClient.h"
#include "QXmppLogger.h"
#include "QXmppMessage.h"
#include "QXmppRosterManager.h"
#include "xmppclient.h"

#include "alarmdialog.h"
#include "ui_window_polkan.h"

using namespace std;

namespace Ui {
    class PolkanMaster;
}

class PolkanMaster : public QMainWindow
{
    Q_OBJECT

public:
    explicit PolkanMaster(QWidget *parent = 0);
    ~PolkanMaster();

private:
    Ui::MainWindow *ui;

    bool wasinput;
    QString lastport;

    bool timeFiltering;
    QTimer timer;
    bool timer1enabled;
    bool timer2enabled;

    bool testmode;

public:
    bool door1, door2;

    QThread *thread_New;
    Port *PortNew;

    xmppClient client;

    void print(QString s, QString color = "black");
    void printUserMessage(QString msg, QString who = "Eddie");
    void clear();
    void processRequest(QString s);
    void StartListening(QString portName);

    void indicateSensors(int x, QString s = "");
    void indicateClient(int x, QString s = "");

    void SendMessageToAllExcept(QString msg, QString who, QString exc);

signals:
    void Alert(int door);
    void LetsConnect();
    void LetsDisconnect();
    void SaveSettings(QString s,int a,int b,int c,int d,int e);

public slots:
    void clearTextMessages();
    void refreshTimeOnTimelabel();
    void sendRequest();

    void DoSomeAlert(int door);
    void TestNotify();
    void TestAlarmDialog();

    // Слоты COM-порта

    void PrintError(QString err, bool good = true);
    void ProcessInput(QString input);
    void SwitchTimeFiltering(bool newvalue);
    void AllowRecieving1();
    void AllowRecieving2();

    // Слоты jabber

    void ClientConnected();
    void ClientDisconnected();
    void RosterRecieved();
    void MessageReceived(const QXmppMessage& msg);
};

#endif // MAINWINDOW_H
