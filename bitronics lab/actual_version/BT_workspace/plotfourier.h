#ifndef PLOTFOURIER_H
#define PLOTFOURIER_H

#include <cmath>

#include "fouriertrigger.h"
#include "plot.h"
#include "bank.h"

typedef double DATA;

const double PL_FOURIER_YAXIS_RANGE_MAXIMUM = 1.2; // Вольт

class PlotFourier : public Plot
{
    Q_OBJECT

public:
    explicit PlotFourier(QObject *parent = 0);
    ~PlotFourier();

    void setPlot(QCustomPlot *plot);

    void setSignalType(SignalType signalType) { this->signalType = signalType; }
    SignalType getSignalType() { return signalType; }

    QVector<double> &getXArr() { return *xArr; }
    QVector<double> &getYArr() { return *yArr; }

    void rescaleFourier(double maxFreq, double stepFreq);

private:
    SignalType signalType;
    QVector<DATA> *xArr, *yArr;
    FourierTrigger *triggers;
    QCPBars *bars;

signals:
    void sign_nextProcess();

    void sign_triggerTriggered(SignalType signalType, TriggerId id, bool triggered);
    void sign_fourierPlease();

    void sign_setTrigger1On(bool on);
    void sign_setTrigger2On(bool on);
    void sign_setTrigger3On(bool on);

    void sign_setTrigger1Position(double pos);
    void sign_setTrigger2Position(double pos);
    void sign_setTrigger3Position(double pos);

    void sign_setTrigger1Height(double height);
    void sign_setTrigger2Height(double height);
    void sign_setTrigger3Height(double height);

    void sign_setTrigger1Width(double width);
    void sign_setTrigger2Width(double width);
    void sign_setTrigger3Width(double width);

public slots:
    void slot_processData();
    void slot_continueProcessing();
    void slot_triggerTriggered(bool on, TriggerId id);
    virtual void slot_mouseWheel(QWheelEvent*);

};

#endif // PLOTFOURIER_H

