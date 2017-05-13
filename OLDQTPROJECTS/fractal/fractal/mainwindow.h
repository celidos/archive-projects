#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QRadioButton>
#include "fractalpainter.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    FractalPainter *fPainter;
    ~MainWindow();

private:
    Ui::MainWindow *ui;

public slots:
    void slotDraw();
    void slotSaveOnDisk();
    void riseIterUp();
    void riseIterDown();
};

#endif // MAINWINDOW_H
