#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QLabel>
#include "vidcap.h"

namespace Ui {
    class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private:
    Ui::MainWindow *ui;
    Vidcap *vidcap;

    CvCapture *c;

private slots:
    void ShowNewFrame(IplImage * frame);
    void createMyThread();
};

#endif // MAINWINDOW_H
