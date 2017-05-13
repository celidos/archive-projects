#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QApplication>
#include <QFile>
#include <QMessageBox>

#include "QXmppClient.h"
#include "QXmppLogger.h"
#include "QXmppMessage.h"
#include "QXmppRosterManager.h"

#include <iostream>
#include <fstream>
#include <string>

#include "ui_mainwindow.h"

using namespace std;

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
    QXmppClient *client;


    void print(QString s, QString color = "black");
    void DoAlarm(int door);

private:
    Ui::MainWindow *ui;

public slots:
    void MessageReceived(const QXmppMessage& msg);
    void sendRequest();

};

#endif // MAINWINDOW_H
