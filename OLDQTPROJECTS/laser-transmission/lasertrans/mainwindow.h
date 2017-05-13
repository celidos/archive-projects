#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QThread>

#include "port.h"
#include "qextserialenumerator.h"


namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

    QThread *thread_New;
    Port *PortNew;

    void print(QString s, QString color = "black");

private:
    Ui::MainWindow *ui;
signals:
    void LetsConnect();
    void LetsDisconnect();
    void SaveSettings(QString s,int a,int b,int c,int d,int e);
    void SendBySerial(QByteArray buf);

public slots:
    void ClearTextMessages();
    void StartListening();
    void RefreshPortsList();
    void Disconnect();
    void PrintError(QString err, bool good = true);
    void ProcessInput(QByteArray buf);
    void SendText1();

};

#endif // MAINWINDOW_H
