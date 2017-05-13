#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QtGui>
#include <QLineEdit>

#include "ui_window_polkan.h"

#include <iostream>

#include "alarmdialog.h"

#include <QtGui>
#include <QTextEdit>
#include <QString>
#include <QList>
#include <QDebug>
#include <QLabel>
#include <QApplication>
#include <QCheckBox>
#include <QTimer>

#include <sstream>

#include "qextserialenumerator.h"
#include "port.h"

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

    bool c_WaitingResponse;
    bool wasinput;
    QString lastport;

    bool timeFiltering;
    QTimer timer;
    bool timer1enabled;
    bool timer2enabled;

public:
    bool door1, door2;

    QThread *thread_New;
    Port *PortNew;

    void print(QString s, QString color = "black");
    void clear();
    void processRequest(QString s);
    void StartListening(QString portName);

    void indicateSensors(int x, QString s = "");

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

    // Слоты COM-порта

    void PrintError(QString err, bool good);
    void ProcessInput(QString input);
    void SwitchTimeFiltering(bool newvalue);
    void AllowRecieving1();
    void AllowRecieving2();
};

#endif // MAINWINDOW_H
