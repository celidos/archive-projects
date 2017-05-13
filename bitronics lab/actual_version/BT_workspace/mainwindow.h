/****************************************************************************
**
** Copyright (C) 2012 Denis Shienkov <denis.shienkov@gmail.com>
** Copyright (C) 2012 Laszlo Papp <lpapp@kde.org>
** Contact: http://www.qt.io/licensing/
**
** This file is part of the QtSerialPort module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL21$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 or version 3 as published by the Free
** Software Foundation and appearing in the file LICENSE.LGPLv21 and
** LICENSE.LGPLv3 included in the packaging of this file. Please review the
** following information to ensure the GNU Lesser General Public License
** requirements will be met: https://www.gnu.org/licenses/lgpl.html and
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** As a special exception, The Qt Company gives you certain additional
** rights. These rights are described in The Qt Company LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <ctime>
#include <QtCore/QtGlobal>
#include <QMainWindow>
#include <QtSerialPort/QSerialPort>

#include "enumeration.h"

//#include "plotsimple.h"
//#include "plotfourier.h"
//#include "plotdiff.h"
#include "parcer.h"
#include "logger.h"
#include "bank.h"
#include "fourier.h"
#include "plot.h"
#include "plotemg.h"
#include "settingsdialog.h"
#include "serialportmaster.h"

QT_BEGIN_NAMESPACE

namespace Ui {
class MainWindow;
}

QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

    const QVector<double> *getYArrForFourier(SignalType signType) const;

private:
    Ui::MainWindow *ui;

    const int TIMER_PLOT_UPDATE_TIME = 30;

    QTimer *timerPlotUpdate;
    QSerialPort *serial;
    SerialPortMaster *serialmaster;
    Parcer* parcer;
    DataBank* bank;

    SettingsDialog *settings;

    Plot*        plotVisualA0;
    Plot*        plotVisualA1;
    Plot*        plotVisualA2;
    Plot*        plotVisualA3;
    Plot*        plotEEG;
    PlotFourier* plotEEGfourier;
    PlotEMG*     plotEMG;
    PlotFourier* plotEMGfourier;
    Plot*        plotKGR;
    PlotDiff*    plotKGRdiff;
    Plot*        plotPulse;

    QThread* thread;
    Fourier* fourier_;
    Logger* logger_;

    // METHODS ------------------

    void initialize();
    void initConnections();
        void initUiConnections();
        void initLogicConnections();
        void initPlots();
        void connectPlots();
    void hideUiElements();

signals:
    void sign_reconnect();
    void sign_update();

public slots:
    void slot_update();
    void slot_updateLinksToPlots();
    void slot_logData(bool firstTime);
    void slot_triggerTriggered(SignalType,TriggerId,bool);
    void slot_fourierPlease();

    void slot_setLabelVisual01(double, double);
    void slot_setLabelVisual02(double, double);
    void slot_setLabelVisual11(double, double);
    void slot_setLabelVisual12(double, double);
    void slot_setLabelVisual21(double, double);
    void slot_setLabelVisual22(double, double);
    void slot_setLabelVisual31(double, double);
    void slot_setLabelVisual32(double, double);

    void slot_setLabelEMG1(double, double);
    void slot_setLabelEMG2(double, double);
    void slot_setLabelEMGFourier1(double, double);
    void slot_setLabelEMGFourier2(double, double);

    void slot_setLabelEEG1(double, double);
    void slot_setLabelEEG2(double, double);

    void slot_setLabelEEGFourier1(double, double);
    void slot_setLabelEEGFourier2(double, double);

    void slot_setLabelKGR1(double, double);
    void slot_setLabelKGR2(double, double);

    void slot_setLabelKGRdiff1(double, double);
    void slot_setLabelKGRdiff2(double, double);

    void slot_setLabelPulse1(double, double);
    void slot_setLabelPulse2(double, double);

private slots:
    void changeConnection(bool);        // ok
    void openSerialPort();              // ok
    void closeSerialPort();             // ok
    void writeData(const QByteArray &data); // ok
    void readData();                    // ok, but TTPS deleted!

    void handleError(QSerialPort::SerialPortError error);               // ok
    void on_actionExit_triggered();
};

#endif // MAINWINDOW_H
