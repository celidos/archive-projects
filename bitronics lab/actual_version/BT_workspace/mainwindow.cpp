#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "settingsdialog.h"
#include "enumeration.h"

#include <QTimer>
#include <QElapsedTimer>
#include <QVector>
#include <QMessageBox>
#include <QtSerialPort/QSerialPort>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow),
    timerPlotUpdate(new QTimer)
{
    ui->setupUi(this);

    initialize();
}

void MainWindow::initialize()
{
    setCentralWidget(ui->widget);

    ui->actionConnect->setEnabled(true);
    ui->actionConfigure->setEnabled(true);
    ui->actionLog->setEnabled(false);

    settings = new SettingsDialog(this);
    settings->setModal(true);

    serial = new QSerialPort(this);
    serialmaster = new SerialPortMaster(this);
    parcer = new Parcer(this);
    bank = new DataBank(this);

    thread = new QThread(this);
    fourier_ = new Fourier;
    logger_ = new Logger;

    initPlots();
    initConnections();
    hideUiElements();

    fourier_->moveToThread(thread);
    logger_->moveToThread(thread);
    thread->start();
}

MainWindow::~MainWindow()
{
    thread->exit();
    delete fourier_;
    delete logger_;
    delete ui;
}

void MainWindow::initConnections()
{
    initUiConnections();
    initLogicConnections();
}

void MainWindow::initUiConnections()
{
    // Возможность скейлить ось Y колесиком мыши
    connect(ui->plotEEGfourier, SIGNAL(mouseWheel(QWheelEvent*)),
            plotEEGfourier, SLOT(slot_mouseWheel(QWheelEvent*)));
    connect(ui->plotEMGfourier, SIGNAL(mouseWheel(QWheelEvent*)),
            plotEMGfourier, SLOT(slot_mouseWheel(QWheelEvent*)));

    //connect(ui->plotKGR, SIGNAL(mouseWheel(QWheelEvent*)),
    //plotKGR, SLOT(slot_rescaleWithMouseWheel(QWheelEvent*)));
    //connect(ui->plotKGRdiff, SIGNAL(mouseWheel(QWheelEvent*)),
            //plotKGRdiff, SLOT(slot_mouseWheel(QWheelEvent*)));

    connect(ui->actionConnect, SIGNAL(triggered(bool)), this, SLOT(changeConnection(bool)));
    connect(ui->actionConfigure, SIGNAL(triggered()), settings, SLOT(exec()));
    connect(ui->actionLog, SIGNAL(triggered(bool)), this, SLOT(slot_logData(bool)));

    //connect checkBoxs of triggers
    {
        //EEG1
        connect(ui->checkBoxTrigger, SIGNAL(toggled(bool)),
                ui->labelCarry, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger, SIGNAL(toggled(bool)),
                ui->labelPorog, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger, SIGNAL(toggled(bool)),
                ui->labelWide, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger, SIGNAL(toggled(bool)),
                ui->labelCarry2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger, SIGNAL(toggled(bool)),
                ui->labelPorog2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger, SIGNAL(toggled(bool)),
                ui->labelWide2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger, SIGNAL(toggled(bool)),
                ui->spinCarry, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger, SIGNAL(toggled(bool)),
                ui->spinPorog, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger, SIGNAL(toggled(bool)),
                ui->spinWide, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger, SIGNAL(toggled(bool)),
                ui->labelTrigger_0, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger, SIGNAL(toggled(bool)),
                ui->lineTrigger_0, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger, SIGNAL(toggled(bool)),
                ui->lineTrigger_0_0, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger, SIGNAL(toggled(bool)),
                ui->labelTriggerFeedBack, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger, SIGNAL(toggled(bool)),
                ui->label_0, SLOT(setVisible(bool)));

        //EEG2
        connect(ui->checkBoxTrigger_2, SIGNAL(toggled(bool)),
                ui->labelCarry_2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_2, SIGNAL(toggled(bool)),
                ui->labelPorog_2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_2, SIGNAL(toggled(bool)),
                ui->labelWide_2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_2, SIGNAL(toggled(bool)),
                ui->labelCarry2_2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_2, SIGNAL(toggled(bool)),
                ui->labelPorog2_2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_2, SIGNAL(toggled(bool)),
                ui->labelWide2_2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_2, SIGNAL(toggled(bool)),
                ui->spinCarry_2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_2, SIGNAL(toggled(bool)),
                ui->spinPorog_2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_2, SIGNAL(toggled(bool)),
                ui->spinWide_2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_2, SIGNAL(toggled(bool)),
                ui->labelTrigger_1, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_2, SIGNAL(toggled(bool)),
                ui->lineTrigger_1, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_2, SIGNAL(toggled(bool)),
                ui->lineTrigger_1_0, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_2, SIGNAL(toggled(bool)),
                ui->labelTriggerFeedBack_2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_2, SIGNAL(toggled(bool)),
                ui->label_1, SLOT(setVisible(bool)));

        //EEG3
        connect(ui->checkBoxTrigger_3, SIGNAL(toggled(bool)),
                ui->labelCarry_3, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_3, SIGNAL(toggled(bool)),
                ui->labelPorog_3, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_3, SIGNAL(toggled(bool)),
                ui->labelWide_3, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_3, SIGNAL(toggled(bool)),
                ui->labelCarry2_3, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_3, SIGNAL(toggled(bool)),
                ui->labelPorog2_3, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_3, SIGNAL(toggled(bool)),
                ui->labelWide2_3, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_3, SIGNAL(toggled(bool)),
                ui->spinCarry_3, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_3, SIGNAL(toggled(bool)),
                ui->spinPorog_3, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_3, SIGNAL(toggled(bool)),
                ui->spinWide_3, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_3, SIGNAL(toggled(bool)),
                ui->labelTrigger_2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_3, SIGNAL(toggled(bool)),
                ui->lineTrigger_2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_3, SIGNAL(toggled(bool)),
                ui->lineTrigger_2_0, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_3, SIGNAL(toggled(bool)),
                ui->labelTriggerFeedBack_3, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_3, SIGNAL(toggled(bool)),
                ui->label_2, SLOT(setVisible(bool)));

        //EMG1
        connect(ui->checkBoxTrigger_4, SIGNAL(toggled(bool)),
                ui->labelCarry_4, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_4, SIGNAL(toggled(bool)),
                ui->labelPorog_4, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_4, SIGNAL(toggled(bool)),
                ui->labelWide_4, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_4, SIGNAL(toggled(bool)),
                ui->labelCarry2_4, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_4, SIGNAL(toggled(bool)),
                ui->labelPorog2_4, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_4, SIGNAL(toggled(bool)),
                ui->labelWide2_4, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_4, SIGNAL(toggled(bool)),
                ui->spinCarry_4, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_4, SIGNAL(toggled(bool)),
                ui->spinPorog_4, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_4, SIGNAL(toggled(bool)),
                ui->spinWide_4, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_4, SIGNAL(toggled(bool)),
                ui->labelTrigger_3, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_4, SIGNAL(toggled(bool)),
                ui->lineTrigger_3, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_4, SIGNAL(toggled(bool)),
                ui->lineTrigger_3_0, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_4, SIGNAL(toggled(bool)),
                ui->labelTriggerFeedBack_4, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_4, SIGNAL(toggled(bool)),
                ui->label_3, SLOT(setVisible(bool)));

        //EMG2
        connect(ui->checkBoxTrigger_5, SIGNAL(toggled(bool)),
                ui->labelCarry_5, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_5, SIGNAL(toggled(bool)),
                ui->labelPorog_5, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_5, SIGNAL(toggled(bool)),
                ui->labelWide_5, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_5, SIGNAL(toggled(bool)),
                ui->labelCarry2_5, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_5, SIGNAL(toggled(bool)),
                ui->labelPorog2_5, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_5, SIGNAL(toggled(bool)),
                ui->labelWide2_5, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_5, SIGNAL(toggled(bool)),
                ui->spinCarry_5, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_5, SIGNAL(toggled(bool)),
                ui->spinPorog_5, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_5, SIGNAL(toggled(bool)),
                ui->spinWide_5, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_5, SIGNAL(toggled(bool)),
                ui->labelTrigger_4, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_5, SIGNAL(toggled(bool)),
                ui->lineTrigger_4, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_5, SIGNAL(toggled(bool)),
                ui->lineTrigger_4_0, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_5, SIGNAL(toggled(bool)),
                ui->labelTriggerFeedBack_5, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_5, SIGNAL(toggled(bool)),
                ui->label_4, SLOT(setVisible(bool)));

        //EMG1
        connect(ui->checkBoxTrigger_6, SIGNAL(toggled(bool)),
                ui->labelCarry_6, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_6, SIGNAL(toggled(bool)),
                ui->labelPorog_6, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_6, SIGNAL(toggled(bool)),
                ui->labelWide_6, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_6, SIGNAL(toggled(bool)),
                ui->labelCarry2_6, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_6, SIGNAL(toggled(bool)),
                ui->labelPorog2_6, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_6, SIGNAL(toggled(bool)),
                ui->labelWide2_6, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_6, SIGNAL(toggled(bool)),
                ui->spinCarry_6, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_6, SIGNAL(toggled(bool)),
                ui->spinPorog_6, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_6, SIGNAL(toggled(bool)),
                ui->spinWide_6, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_6, SIGNAL(toggled(bool)),
                ui->labelTrigger_5, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_6, SIGNAL(toggled(bool)),
                ui->lineTrigger_5, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_6, SIGNAL(toggled(bool)),
                ui->lineTrigger_5_0, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_6, SIGNAL(toggled(bool)),
                ui->labelTriggerFeedBack_6, SLOT(setVisible(bool)));
        connect(ui->checkBoxTrigger_6, SIGNAL(toggled(bool)),
                ui->label_5, SLOT(setVisible(bool)));

        //EMG0
        connect(ui->checkBoxTriggerEMG, SIGNAL(toggled(bool)),
                ui->labelPorogEMG, SLOT(setVisible(bool)));
        connect(ui->checkBoxTriggerEMG, SIGNAL(toggled(bool)),
                ui->labelWideEMG, SLOT(setVisible(bool)));
        connect(ui->checkBoxTriggerEMG, SIGNAL(toggled(bool)),
                ui->labelPorogEMG2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTriggerEMG, SIGNAL(toggled(bool)),
                ui->labelWideEMG2, SLOT(setVisible(bool)));
        connect(ui->checkBoxTriggerEMG, SIGNAL(toggled(bool)),
                ui->spinPorogEMG, SLOT(setVisible(bool)));
        connect(ui->checkBoxTriggerEMG, SIGNAL(toggled(bool)),
                ui->spinWideEMG, SLOT(setVisible(bool)));
        connect(ui->checkBoxTriggerEMG, SIGNAL(toggled(bool)),
                ui->lineTriggerEMG, SLOT(setVisible(bool)));
        connect(ui->checkBoxTriggerEMG, SIGNAL(toggled(bool)),
                ui->lineTriggerEMG_0, SLOT(setVisible(bool)));
        connect(ui->checkBoxTriggerEMG, SIGNAL(toggled(bool)),
                ui->labelTriggerFeedBackEMG, SLOT(setVisible(bool)));
        connect(ui->checkBoxTriggerEMG, SIGNAL(toggled(bool)),
                ui->labelBackEMG, SLOT(setVisible(bool)));
        connect(ui->checkBoxTriggerEMG, SIGNAL(toggled(bool)),
                ui->label_EMG, SLOT(setVisible(bool)));
    }
}

void MainWindow::initLogicConnections()
{
    /// ???
    connect(this, SIGNAL(sign_reconnect()), bank, SLOT(slot_clear()));
    connect(this, SIGNAL(sign_reconnect()), plotEMG, SLOT(slot_clear()));
    connect(this, SIGNAL(sign_reconnect()), plotEMGfourier, SLOT(slot_clear()));
    connect(this, SIGNAL(sign_reconnect()), plotEEG, SLOT(slot_clear()));
    connect(this, SIGNAL(sign_reconnect()), plotEEGfourier, SLOT(slot_clear()));
    connect(this, SIGNAL(sign_reconnect()), plotKGR, SLOT(slot_clear()));
    //connect(this, SIGNAL(sign_reconnect()), plotKGRdiff, SLOT(slot_clear()));
    connect(this, SIGNAL(sign_reconnect()), plotPulse, SLOT(slot_clear()));

    // Порт <--> Обработчик данных
    connect(serialmaster->serial, SIGNAL(readyRead()), this, SLOT(readData()));

    // Порт <--> Обработчик ошибок
    connect(serial, SIGNAL(error(QSerialPort::SerialPortError)), this,
            SLOT(handleError(QSerialPort::SerialPortError)));

    // Соединение parcer с bank
    connect(parcer, SIGNAL(sign_newDataParced(Channel,DATA)), bank, SLOT(slot_receiveNewData(Channel,DATA)));
    connect(parcer, SIGNAL(sign_endOfSession()), bank, SLOT(slot_endOfSession()));

    // Соединение банка с остальными будет происходить в момент вызова setConnections

    connect(this->settings, SIGNAL(sign_updateLinks()), this, SLOT(slot_updateLinksToPlots()));
}

void MainWindow::initPlots()
{
    auto set = settings->settings();

    plotVisualA0    = new Plot(this);
    plotVisualA0->setPlot(ui->plotVisualA0);
    plotVisualA0->setSource(bank->getXArr(A0), bank->getYArr(A0));
    connect(plotVisualA0, SIGNAL(sign_label1(double,double)), this, SLOT(slot_setLabelVisual01(double,double)));
    connect(plotVisualA0, SIGNAL(sign_label2(double,double)), this, SLOT(slot_setLabelVisual02(double,double)));

    plotVisualA1    = new Plot(this);
    plotVisualA1->setPlot(ui->plotVisualA1);
    plotVisualA1->setSource(bank->getXArr(A1), bank->getYArr(A1));
    connect(plotVisualA1, SIGNAL(sign_label1(double,double)), this, SLOT(slot_setLabelVisual11(double,double)));
    connect(plotVisualA1, SIGNAL(sign_label2(double,double)), this, SLOT(slot_setLabelVisual12(double,double)));

    plotVisualA2    = new Plot(this);
    plotVisualA2->setPlot(ui->plotVisualA2);
    plotVisualA2->setSource(bank->getXArr(A2), bank->getYArr(A2));
    connect(plotVisualA2, SIGNAL(sign_label1(double,double)), this, SLOT(slot_setLabelVisual21(double,double)));
    connect(plotVisualA2, SIGNAL(sign_label2(double,double)), this, SLOT(slot_setLabelVisual22(double,double)));
    plotVisualA3    = new Plot(this);
    plotVisualA3->setPlot(ui->plotVisualA3);
    plotVisualA3->setSource(bank->getXArr(A3), bank->getYArr(A3));
    connect(plotVisualA3, SIGNAL(sign_label1(double,double)), this, SLOT(slot_setLabelVisual31(double,double)));
    connect(plotVisualA3, SIGNAL(sign_label2(double,double)), this, SLOT(slot_setLabelVisual32(double,double)));

    plotEEG         = new Plot(this);
    plotEEG->setPlot(ui->plotEEG);
    plotEEG->setSource(bank->getXArr(set.channelEEG),
                       bank->getYArr(set.channelEEG));
    connect(plotEEG, SIGNAL(sign_label1(double,double)), this, SLOT(slot_setLabelEEG1(double,double)));
    connect(plotEEG, SIGNAL(sign_label2(double,double)), this, SLOT(slot_setLabelEEG2(double,double)));

    //    FourierTrigger eeg1(6,  1);
    //    FourierTrigger eeg2(12, 2);
    //    FourierTrigger eeg3(20, 3);
    plotEEGfourier  = new PlotFourier(this);
    plotEEGfourier->setSignalType(EEG);
    plotEEGfourier->setPlot(ui->plotEEGfourier);
    connect(plotEEGfourier, SIGNAL(sign_label1(double,double)), this, SLOT(slot_setLabelEEGFourier1(double,double)));
    connect(plotEEGfourier, SIGNAL(sign_label2(double,double)), this, SLOT(slot_setLabelEEGFourier2(double,double)));

    connect(plotEEG, SIGNAL(sign_nextProcess()),
            plotEEGfourier, SLOT(slot_processData()));
    connect(plotEEGfourier, SIGNAL(sign_fourierPlease()),
            this, SLOT(slot_fourierPlease()));

    // коннекты триггеров
    {
        connect(ui->checkBoxTrigger, SIGNAL(toggled(bool)),
                plotEEGfourier, SIGNAL(sign_setTrigger1On(bool)));
        connect(ui->checkBoxTrigger_2, SIGNAL(toggled(bool)),
                plotEEGfourier, SIGNAL(sign_setTrigger2On(bool)));
        connect(ui->checkBoxTrigger_3, SIGNAL(toggled(bool)),
                plotEEGfourier, SIGNAL(sign_setTrigger3On(bool)));

        connect(ui->spinPorog, SIGNAL(valueChanged(double)),
                plotEEGfourier, SIGNAL(sign_setTrigger1Height(double)));
        connect(ui->spinPorog_2, SIGNAL(valueChanged(double)),
                plotEEGfourier, SIGNAL(sign_setTrigger2Height(double)));
        connect(ui->spinPorog_3, SIGNAL(valueChanged(double)),
                plotEEGfourier, SIGNAL(sign_setTrigger3Height(double)));

        connect(ui->spinCarry, SIGNAL(valueChanged(double)),
                plotEEGfourier, SIGNAL(sign_setTrigger1Position(double)));
        connect(ui->spinCarry_2, SIGNAL(valueChanged(double)),
                plotEEGfourier, SIGNAL(sign_setTrigger2Position(double)));
        connect(ui->spinCarry_3, SIGNAL(valueChanged(double)),
                plotEEGfourier, SIGNAL(sign_setTrigger3Position(double)));

        connect(ui->spinWide, SIGNAL(valueChanged(double)),
                plotEEGfourier, SIGNAL(sign_setTrigger1Width(double)));
        connect(ui->spinWide_2, SIGNAL(valueChanged(double)),
                plotEEGfourier, SIGNAL(sign_setTrigger2Width(double)));
        connect(ui->spinWide_3, SIGNAL(valueChanged(double)),
                plotEEGfourier, SIGNAL(sign_setTrigger3Width(double)));

        connect(plotEEGfourier, SIGNAL(sign_triggerTriggered(SignalType,TriggerId,bool)),
                this, SLOT(slot_triggerTriggered(SignalType,TriggerId,bool)));

        emit plotEEGfourier->sign_setTrigger1Height(ui->spinPorog->value());
        emit plotEEGfourier->sign_setTrigger2Height(ui->spinPorog_2->value());
        emit plotEEGfourier->sign_setTrigger3Height(ui->spinPorog_3->value());
        emit plotEEGfourier->sign_setTrigger1Position(ui->spinCarry->value());
        emit plotEEGfourier->sign_setTrigger2Position(ui->spinCarry_2->value());
        emit plotEEGfourier->sign_setTrigger3Position(ui->spinCarry_3->value());
        emit plotEEGfourier->sign_setTrigger1Width(ui->spinWide->value());
        emit plotEEGfourier->sign_setTrigger2Width(ui->spinWide_2->value());
        emit plotEEGfourier->sign_setTrigger3Width(ui->spinWide_3->value());
    }

    plotEMG         = new PlotEMG(this);
    plotEMG->setPlot(ui->plotEMG);
    plotEMG->setSource(bank->getXArr(set.channelEMG),
                       bank->getYArr(set.channelEMG));
    connect(plotEMG, SIGNAL(sign_label1(double,double)), this, SLOT(slot_setLabelEMG1(double,double)));
    connect(plotEMG, SIGNAL(sign_label2(double,double)), this, SLOT(slot_setLabelEMG2(double,double)));

    plotEMG->slot_needTrigger(ui->checkBoxTriggerEMG->isChecked());
    plotEMG->slot_setPorog(ui->spinPorogEMG->value());
    plotEMG->slot_setWide(ui->spinWideEMG->value());

    //    FourierTrigger emg1(20, 4);
    //    FourierTrigger emg2(40, 5);
    //    FourierTrigger emg3(60, 6);
    plotEMGfourier  = new PlotFourier(this);
    plotEMGfourier->setSignalType(EMG);
    plotEMGfourier->setPlot(ui->plotEMGfourier);
    connect(plotEMGfourier, SIGNAL(sign_label1(double,double)), this, SLOT(slot_setLabelEMGFourier1(double,double)));
    connect(plotEMGfourier, SIGNAL(sign_label2(double,double)), this, SLOT(slot_setLabelEMGFourier2(double,double)));

    connect(plotEMG, SIGNAL(sign_nextProcess()),
            plotEMGfourier, SLOT(slot_processData()));
    connect(plotEMGfourier, SIGNAL(sign_fourierPlease()),
            this, SLOT(slot_fourierPlease()));

    // коннекты триггеров
    {
        connect(ui->checkBoxTriggerEMG, SIGNAL(toggled(bool)),
                plotEMG, SLOT(slot_needTrigger(bool)));
        connect(ui->spinPorogEMG, SIGNAL(valueChanged(double)),
                plotEMG, SLOT(slot_setPorog(double)));
        connect(ui->spinWideEMG, SIGNAL(valueChanged(double)),
                plotEMG, SLOT(slot_setWide(double)));
        connect(plotEMG, SIGNAL(sign_triggerTriggered(SignalType,TriggerId,bool)),
                this, SLOT(slot_triggerTriggered(SignalType,TriggerId,bool)));

        connect(ui->checkBoxTrigger_4, SIGNAL(toggled(bool)),
                plotEMGfourier, SIGNAL(sign_setTrigger1On(bool)));
        connect(ui->checkBoxTrigger_5, SIGNAL(toggled(bool)),
                plotEMGfourier, SIGNAL(sign_setTrigger2On(bool)));
        connect(ui->checkBoxTrigger_6, SIGNAL(toggled(bool)),
                plotEMGfourier, SIGNAL(sign_setTrigger3On(bool)));

        connect(ui->spinPorog_4, SIGNAL(valueChanged(double)),
                plotEMGfourier, SIGNAL(sign_setTrigger1Height(double)));
        connect(ui->spinPorog_5, SIGNAL(valueChanged(double)),
                plotEMGfourier, SIGNAL(sign_setTrigger2Height(double)));
        connect(ui->spinPorog_6, SIGNAL(valueChanged(double)),
                plotEMGfourier, SIGNAL(sign_setTrigger3Height(double)));

        connect(ui->spinCarry_4, SIGNAL(valueChanged(double)),
                plotEMGfourier, SIGNAL(sign_setTrigger1Position(double)));
        connect(ui->spinCarry_5, SIGNAL(valueChanged(double)),
                plotEMGfourier, SIGNAL(sign_setTrigger2Position(double)));
        connect(ui->spinCarry_6, SIGNAL(valueChanged(double)),
                plotEMGfourier, SIGNAL(sign_setTrigger3Position(double)));

        connect(ui->spinWide_4, SIGNAL(valueChanged(double)),
                plotEMGfourier, SIGNAL(sign_setTrigger1Width(double)));
        connect(ui->spinWide_5, SIGNAL(valueChanged(double)),
                plotEMGfourier, SIGNAL(sign_setTrigger2Width(double)));
        connect(ui->spinWide_6, SIGNAL(valueChanged(double)),
                plotEMGfourier, SIGNAL(sign_setTrigger3Width(double)));

        connect(plotEMGfourier, SIGNAL(sign_triggerTriggered(SignalType,TriggerId,bool)),
                this, SLOT(slot_triggerTriggered(SignalType,TriggerId,bool)));

        emit plotEMGfourier->sign_setTrigger1Height(ui->spinPorog_4->value());
        emit plotEMGfourier->sign_setTrigger2Height(ui->spinPorog_5->value());
        emit plotEMGfourier->sign_setTrigger3Height(ui->spinPorog_6->value());
        emit plotEMGfourier->sign_setTrigger1Position(ui->spinCarry_4->value());
        emit plotEMGfourier->sign_setTrigger2Position(ui->spinCarry_5->value());
        emit plotEMGfourier->sign_setTrigger3Position(ui->spinCarry_6->value());
        emit plotEMGfourier->sign_setTrigger1Width(ui->spinWide_4->value());
        emit plotEMGfourier->sign_setTrigger2Width(ui->spinWide_5->value());
        emit plotEMGfourier->sign_setTrigger3Width(ui->spinWide_6->value());
    }

    plotKGR         = new Plot(this);
    plotKGR->setPlot(ui->plotKGR);
    plotKGR->setSource(bank->getXArr(set.channelKGR),
                       bank->getYArr(set.channelKGR));
    connect(plotKGR, SIGNAL(sign_label1(double,double)), this, SLOT(slot_setLabelKGR1(double,double)));
    connect(plotKGR, SIGNAL(sign_label2(double,double)), this, SLOT(slot_setLabelKGR2(double,double)));

    ui->plotKGRdiff->setVisible(false);
/*  plotKGRdiff     = new PlotDiff(this);
    plotKGRdiff->setSource(plotKGR);
    plotKGRdiff->setPlot(ui->plotKGRdiff);
    connect(plotKGRdiff, SIGNAL(sign_label1(double,double)), this, SLOT(slot_setLabelKGRDiff1(double,double)));
    connect(plotKGRdiff, SIGNAL(sign_label2(double,double)), this, SLOT(slot_setLabelKGRDiff2(double,double)));
*/

    plotPulse       = new Plot(this);
    plotPulse->setPlot(ui->plotPulse);
    plotPulse->setSource(bank->getXArr(set.channelPulse),
                         bank->getYArr(set.channelPulse));
    connect(plotPulse, SIGNAL(sign_label1(double,double)), this, SLOT(slot_setLabelPulse1(double,double)));
    connect(plotPulse, SIGNAL(sign_label2(double,double)), this, SLOT(slot_setLabelPulse2(double,double)));

    connectPlots();
}

void MainWindow::connectPlots()
{
    /*connect(this, SIGNAL(sign_update()),
            plotVisual, SLOT(slot_update()));*/
    connect(this, SIGNAL(sign_update()),
            plotEEG, SLOT(slot_update()));
    connect(this, SIGNAL(sign_update()),
            plotEMG, SLOT(slot_update()));
    connect(this, SIGNAL(sign_update()),
            plotKGR, SLOT(slot_update()));
    connect(this, SIGNAL(sign_update()),
            plotPulse, SLOT(slot_update()));
}

void MainWindow::hideUiElements()
{
    ui->labelTriggerFeedBackEMG->hide();
    ui->labelTrigger_0->hide();
    ui->labelTrigger_1->hide();
    ui->labelTrigger_2->hide();
    ui->labelTrigger_3->hide();
    ui->labelTrigger_4->hide();
    ui->labelTrigger_5->hide();

    ui->lineTriggerEMG->hide();
    ui->lineTrigger_0->hide();
    ui->lineTrigger_1->hide();
    ui->lineTrigger_2->hide();
    ui->lineTrigger_3->hide();
    ui->lineTrigger_4->hide();
    ui->lineTrigger_5->hide();

    ui->lineTriggerEMG_0->hide();
    ui->lineTrigger_0_0->hide();
    ui->lineTrigger_1_0->hide();
    ui->lineTrigger_2_0->hide();
    ui->lineTrigger_3_0->hide();
    ui->lineTrigger_4_0->hide();
    ui->lineTrigger_5_0->hide();

    ui->label_EMG->hide();
    ui->label_0->hide();
    ui->label_1->hide();
    ui->label_2->hide();
    ui->label_3->hide();
    ui->label_4->hide();
    ui->label_5->hide();

    ui->labelTriggerFeedBackEMG->hide();
    ui->labelPorogEMG->hide();
    ui->labelWideEMG->hide();
    ui->labelPorogEMG2->hide();
    ui->labelWideEMG2->hide();
    ui->spinPorogEMG->hide();
    ui->spinWideEMG->hide();
    ui->labelBackEMG->hide();

    ui->labelTriggerFeedBack->hide();
    ui->labelPorog->hide();
    ui->labelCarry->hide();
    ui->labelWide->hide();
    ui->labelPorog2->hide();
    ui->labelCarry2->hide();
    ui->labelWide2->hide();
    ui->spinPorog->hide();
    ui->spinCarry->hide();
    ui->spinWide->hide();

    ui->labelTriggerFeedBack_2->hide();
    ui->labelPorog_2->hide();
    ui->labelCarry_2->hide();
    ui->labelWide_2->hide();
    ui->labelPorog2_2->hide();
    ui->labelCarry2_2->hide();
    ui->labelWide2_2->hide();
    ui->spinPorog_2->hide();
    ui->spinCarry_2->hide();
    ui->spinWide_2->hide();

    ui->labelTriggerFeedBack_3->hide();
    ui->labelPorog_3->hide();
    ui->labelCarry_3->hide();
    ui->labelWide_3->hide();
    ui->labelPorog2_3->hide();
    ui->labelCarry2_3->hide();
    ui->labelWide2_3->hide();
    ui->spinPorog_3->hide();
    ui->spinCarry_3->hide();
    ui->spinWide_3->hide();

    ui->labelTriggerFeedBack_4->hide();
    ui->labelPorog_4->hide();
    ui->labelCarry_4->hide();
    ui->labelWide_4->hide();
    ui->labelPorog2_4->hide();
    ui->labelCarry2_4->hide();
    ui->labelWide2_4->hide();
    ui->spinPorog_4->hide();
    ui->spinCarry_4->hide();
    ui->spinWide_4->hide();

    ui->labelTriggerFeedBack_5->hide();
    ui->labelPorog_5->hide();
    ui->labelCarry_5->hide();
    ui->labelWide_5->hide();
    ui->labelPorog2_5->hide();
    ui->labelCarry2_5->hide();
    ui->labelWide2_5->hide();
    ui->spinPorog_5->hide();
    ui->spinCarry_5->hide();
    ui->spinWide_5->hide();

    ui->labelTriggerFeedBack_6->hide();
    ui->labelPorog_6->hide();
    ui->labelCarry_6->hide();
    ui->labelWide_6->hide();
    ui->labelPorog2_6->hide();
    ui->labelCarry2_6->hide();
    ui->labelWide2_6->hide();
    ui->spinPorog_6->hide();
    ui->spinCarry_6->hide();
    ui->spinWide_6->hide();
}

void MainWindow::slot_triggerTriggered(SignalType signalType, TriggerId id, bool triggered)
{
    switch (signalType) {
    case EEG:
        switch (id) {
        case Trigger1:
            if (triggered) {
                writeData(ui->lineTrigger_0->text().toLatin1());
                ui->labelTriggerFeedBack->setText("1");
            }
            else {
                writeData(ui->lineTrigger_0_0->text().toLatin1());
                ui->labelTriggerFeedBack->setText("0");
            }
            break;
        case Trigger2:
            if (triggered) {
                writeData(ui->lineTrigger_1->text().toLatin1());
                ui->labelTriggerFeedBack_2->setText("1");
            }
            else {
                writeData(ui->lineTrigger_1_0->text().toLatin1());
                ui->labelTriggerFeedBack_2->setText("0");
            }
            break;
        case Trigger3:
            if (triggered) {
                writeData(ui->lineTrigger_2->text().toLatin1());
                ui->labelTriggerFeedBack_3->setText("1");
            }
            else {
                writeData(ui->lineTrigger_2_0->text().toLatin1());
                ui->labelTriggerFeedBack_3->setText("0");
            }
            break;
        }
        break;
    case EMG:
        switch (id) {
        case Trigger0:
            if (triggered) {
                writeData(ui->lineTriggerEMG->text().toLatin1());
                ui->labelTriggerFeedBackEMG->setText("1");
            }
            else {
                writeData(ui->lineTriggerEMG_0->text().toLatin1());
                ui->labelTriggerFeedBackEMG->setText("0");
            }
            break;
        case Trigger1:
            if (triggered) {
                writeData(ui->lineTrigger_3->text().toLatin1());
                ui->labelTriggerFeedBack_4->setText("1");
            }
            else {
                writeData(ui->lineTrigger_3_0->text().toLatin1());
                ui->labelTriggerFeedBack_4->setText("0");
            }
            break;
        case Trigger2:
            if (triggered) {
                writeData(ui->lineTrigger_4->text().toLatin1());
                ui->labelTriggerFeedBack_5->setText("1");
            }
            else {
                writeData(ui->lineTrigger_4_0->text().toLatin1());
                ui->labelTriggerFeedBack_5->setText("0");
            }
            break;
        case Trigger3:
            if (triggered) {
                writeData(ui->lineTrigger_5->text().toLatin1());
                ui->labelTriggerFeedBack_6->setText("1");
            }
            else {
                writeData(ui->lineTrigger_5_0->text().toLatin1());
                ui->labelTriggerFeedBack_6->setText("0");
            }
            break;
        default:
            break;
        }
        break;
    }
}

void MainWindow::changeConnection(bool change)
{
    if(change)
    {
        emit sign_reconnect();
        openSerialPort();
        ui->actionConnect->setToolTip(tr("Отключить порт"));
    }
    else
    {
        closeSerialPort();
        ui->actionConnect->setToolTip(tr("Подключиться к порту"));
    }
}

void MainWindow::slot_update()
{
    qDebug() << "slotUpdate";
    switch (ui->tabWidget->currentIndex()) {
    case 0:
        plotVisualA0->update();
        plotVisualA1->update();
        plotVisualA2->update();
        plotVisualA3->update();
        break;
    case 1:
        plotEMG->update();
        break;
    case 2:
        plotEEG->update();
        break;
    case 3:
        plotKGR->update();
        break;
    case 4:
        plotPulse->update();
        break;
    }
}

void MainWindow::slot_updateLinksToPlots()
{
    auto set = settings->settings();
    qDebug() << "UPDATING!";

    plotPulse->setSource(bank->getXArr(set.channelPulse),
                         bank->getYArr(set.channelPulse));
    plotKGR->setSource(bank->getXArr(set.channelKGR),
                       bank->getYArr(set.channelKGR));
    plotEMG->setSource(bank->getXArr(set.channelEMG),
                       bank->getYArr(set.channelEMG));
    plotEEG->setSource(bank->getXArr(set.channelEEG),
                       bank->getYArr(set.channelEEG));
}

void MainWindow::openSerialPort()
{
    SettingsDialog::Settings p = settings->settings();
    serial->setPortName(p.name);
    serial->setBaudRate(p.baudRate);
    serial->setFlowControl(p.flowControl);
    if (serial->open(QIODevice::ReadWrite)) {
        ui->actionConfigure->setEnabled(false);
        ui->actionLog->setEnabled(true);
        ui->statusBar->showMessage(tr("Подключен к %1 : %2, %3")
                                   .arg(p.name).arg(p.stringBaudRate).arg(p.stringFlowControl));
    } else {
        QMessageBox::critical(this, tr("Ошибка"), serial->errorString());
        ui->statusBar->showMessage(tr("Ошибка подключения"));
        ui->actionConnect->setChecked(false);
        changeConnection(false);
    }

    if (timerPlotUpdate->isActive())
        timerPlotUpdate->stop();
}

void MainWindow::closeSerialPort()
{
    if (serial->isOpen())
        serial->close();
    ui->actionConfigure->setEnabled(true);
    ui->actionLog->setEnabled(false);
    ui->statusBar->showMessage(tr("Отключен"));
}

// Записываем QByteArray в порт
void MainWindow::writeData(const QByteArray &data)
{
    serial->write(data);
}

void MainWindow::readData()
{
    QByteArray data = serial->readAll();

    parcer->parce(data);

    if (!timerPlotUpdate->isActive()) {
        timerPlotUpdate->start(TIMER_PLOT_UPDATE_TIME);
        connect(timerPlotUpdate, SIGNAL(timeout()), this, SLOT(slot_update()));
    }
}

void MainWindow::handleError(QSerialPort::SerialPortError error)
{
    if (error == QSerialPort::ResourceError) {
        QMessageBox::critical(this, tr("Критическая ошибка"), serial->errorString());
        closeSerialPort();
    }
}

const QVector<double>* MainWindow::getYArrForFourier(SignalType signType) const
{
    Channel channel;
    switch (signType) {
    case EMG:
        channel = settings->settings().channelEMG;
        break;
    case EEG:
        channel = settings->settings().channelEEG;
        break;
    default:
        return NULL;
    }

    return bank->getYArr(channel);
}

void MainWindow::slot_logData(bool firstTime)
{
    if (firstTime)
    {
        ui->statusBar->showMessage(tr("Началась запись данных"), 1000);
        ui->actionLog->setToolTip(tr("Начать запись данных"));
        this->logger_->logDataToFile("C:\\BiTronics\\log.csv");
    }
    else
    {
        ui->statusBar->showMessage(tr("Данные сохранены"), 1000);
        ui->actionLog->setToolTip(tr("Закончить запись данных"));
        this->logger_->startLog();
    }
}

void MainWindow::slot_fourierPlease()
{
    qDebug() << "slot_FourierPlease!";
    QVector<double> *fourierData = new QVector<double>;
    const QVector<double> *curr = nullptr;

    int num = 0, inc = 0;

    QVector<double>::ConstIterator end;
    double spinBoxStepFreq = 0.0,
           spinBoxMaxFreq = 0.0;
    PlotFourier *plotf = nullptr;

    switch (static_cast<PlotFourier *>(sender())->getSignalType()) {
    case EMG:
        curr = bank->getYArr(settings->settings().channelEMG);
        end = bank->getXArr(settings->settings().channelEMG)->cend();
        spinBoxMaxFreq = ui->spinBoxEMGMaxFreq->value();
        spinBoxStepFreq = ui->doubleSpinBoxEMGStepFreq->value();
        plotf = plotEMGfourier;
        break;
    case EEG:
        curr = bank->getYArr(settings->settings().channelEEG);
        end = bank->getXArr(settings->settings().channelEEG)->cend();
        spinBoxMaxFreq = ui->spinBoxEEGMaxFreq->value();
        spinBoxStepFreq = ui->doubleSpinBoxEEGStepFreq->value();
        plotf = plotEEGfourier;
        break;
    }

    if (curr->size() < 8)
    {
        delete fourierData;
        return;
    }

    inc = 1.0 / (*(end-1) - *(end-3)) / spinBoxMaxFreq;
    if (inc <= 1)
        inc = 1;

    qDebug() << "inc = " << inc << "; size = " << bank->getXArr(settings->settings().channelEMG)->size();

    for (num = 2; num < int(1.0 / (*(end-1) - *(end-1-inc)) / spinBoxStepFreq); num *= 2);

    while (curr->size() < inc*num)
        num /= 2;

    if (num*inc >= curr->size()) {
        qDebug() << "Too small size: " << curr->size();
        delete fourierData;
        return;
    }

    for (auto it = curr->cend() - 1; num-- > 0; it -= inc)
        fourierData->append(*it);

    plotf->rescaleFourier(ui->spinBoxEMGMaxFreq->value(), 0.39);// 1.0/(*(end-1) - *(end-1-inc*arr->size())));


    if (fourierData->size() > 64)
        fourier_->slot_doFourier(fourierData, static_cast<PlotFourier*>(sender()));
    delete fourierData;
}

void MainWindow::slot_setLabelVisual01(double x, double y)
{
    ui->labelVisual0x1->setText(QString::number(x, 'f', 2));
    ui->labelVisual0y1->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelVisual02(double x, double y)
{
    ui->labelVisual0x2->setText(QString::number(x, 'f', 2));
    ui->labelVisual0y2->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelVisual11(double x, double y)
{
    ui->labelVisual1x1->setText(QString::number(x, 'f', 2));
    ui->labelVisual1y1->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelVisual12(double x, double y)
{
    ui->labelVisual1x2->setText(QString::number(x, 'f', 2));
    ui->labelVisual1y2->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelVisual21(double x, double y)
{
    ui->labelVisual2x1->setText(QString::number(x, 'f', 2));
    ui->labelVisual2y1->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelVisual22(double x, double y)
{
    ui->labelVisual2x2->setText(QString::number(x, 'f', 2));
    ui->labelVisual2y2->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelVisual31(double x, double y)
{
    ui->labelVisual3x1->setText(QString::number(x, 'f', 2));
    ui->labelVisual3y1->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelVisual32(double x, double y)
{
    ui->labelVisual3x2->setText(QString::number(x, 'f', 2));
    ui->labelVisual3y2->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelEMG1(double x, double y)
{
    ui->labelEMGx1->setText(QString::number(x, 'f', 2));
    ui->labelEMGy1->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelEMG2(double x, double y)
{
    ui->labelEMGx2->setText(QString::number(x, 'f', 2));
    ui->labelEMGy2->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelEMGFourier1(double x, double y)
{
    ui->labelEMGFourierx1->setText(QString::number(x, 'f', 2));
    ui->labelEMGFouriery1->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelEMGFourier2(double x, double y)
{
    ui->labelEMGFourierx2->setText(QString::number(x, 'f', 2));
    ui->labelEMGFouriery2->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelEEG1(double x, double y)
{
    ui->labelEEGx1->setText(QString::number(x, 'f', 2));
    ui->labelEEGy1->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelEEG2(double x, double y)
{
    ui->labelEEGx2->setText(QString::number(x, 'f', 2));
    ui->labelEEGy2->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelEEGFourier1(double x, double y)
{
    ui->labelEEGFourierx1->setText(QString::number(x, 'f', 2));
    ui->labelEEGFouriery1->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelEEGFourier2(double x, double y)
{
    ui->labelEEGFourierx2->setText(QString::number(x, 'f', 2));
    ui->labelEEGFouriery2->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelKGR1(double x, double y)
{
    ui->labelKGRx1->setText(QString::number(x, 'f', 2));
    ui->labelKGRy1->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelKGR2(double x, double y)
{
    ui->labelKGRx2->setText(QString::number(x, 'f', 2));
    ui->labelKGRy2->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelKGRdiff1(double x, double y)
{
    ui->labelKGRDiffx1->setText(QString::number(x, 'f', 2));
    ui->labelKGRDiffy1->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelKGRdiff2(double x, double y)
{
    ui->labelKGRDiffx2->setText(QString::number(x, 'f', 2));
    ui->labelKGRDiffy2->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelPulse1(double x, double y)
{
    ui->labelPulsex1->setText(QString::number(x, 'f', 2));
    ui->labelPulsey1->setText(QString::number(y, 'f', 2));
}

void MainWindow::slot_setLabelPulse2(double x, double y)
{
    ui->labelPulsex2->setText(QString::number(x, 'f', 2));
    ui->labelPulsey2->setText(QString::number(y, 'f', 2));
}

void MainWindow::on_actionExit_triggered()
{
    closeSerialPort();
    close();
}
