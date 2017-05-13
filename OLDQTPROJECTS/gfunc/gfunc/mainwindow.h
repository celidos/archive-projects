#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <cmath>

#include "graphbuilder.h"
#include "ui_mainwindow.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    GraphBuilder *gBuilder;
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private:
    Ui::MainWindow *ui;
public slots:
    void Calculate();
    void CopyEditValues();
    void Solve();

    void RefreshEps();
};

#endif // MAINWINDOW_H
