#include "plotfourier.h"
#include "mainwindow.h"

PlotFourier::PlotFourier(QObject *parent):
    Plot(parent),
    xArr(new QVector<double>),
    yArr(new QVector<double>),
    triggers(new FourierTrigger(this)),
    bars(nullptr)
{
    connect(this, SIGNAL(sign_setTrigger1On(bool)),
            triggers, SLOT(slot_set1On(bool)));
    connect(this, SIGNAL(sign_setTrigger2On(bool)),
            triggers, SLOT(slot_set2On(bool)));
    connect(this, SIGNAL(sign_setTrigger3On(bool)),
            triggers, SLOT(slot_set3On(bool)));

    connect(this, SIGNAL(sign_setTrigger1Position(double)),
            triggers, SLOT(slot_set1Position(double)));
    connect(this, SIGNAL(sign_setTrigger2Position(double)),
            triggers, SLOT(slot_set2Position(double)));
    connect(this, SIGNAL(sign_setTrigger3Position(double)),
            triggers, SLOT(slot_set3Position(double)));

    connect(this, SIGNAL(sign_setTrigger1Height(double)),
            triggers, SLOT(slot_set1Height(double)));
    connect(this, SIGNAL(sign_setTrigger2Height(double)),
            triggers, SLOT(slot_set2Height(double)));
    connect(this, SIGNAL(sign_setTrigger3Height(double)),
            triggers, SLOT(slot_set3Height(double)));

    connect(this, SIGNAL(sign_setTrigger1Width(double)),
            triggers, SLOT(slot_set1Width(double)));
    connect(this, SIGNAL(sign_setTrigger2Width(double)),
            triggers, SLOT(slot_set2Width(double)));
    connect(this, SIGNAL(sign_setTrigger3Width(double)),
            triggers, SLOT(slot_set3Width(double)));

    connect(triggers, SIGNAL(sign_triggerTriggered(bool, TriggerId)),
            this, SLOT(slot_triggerTriggered(bool, TriggerId)));
}

PlotFourier::~PlotFourier()
{
    delete xArr;
    delete yArr;
}

void PlotFourier::setPlot(QCustomPlot *plot)
{
    this->plot = plot;
    plot->addGraph();

    bars = new QCPBars(plot->xAxis, plot->yAxis);

    plot->addPlottable(bars);

    plot->xAxis->setRange(0, 100);
    plot->xAxis->setAutoTickStep(false);
    plot->xAxis->setTickStep(10);
    plot->yAxis->setRange(0, PL_FOURIER_YAXIS_RANGE_MAXIMUM);

    triggers->setSource(plot);
}

void PlotFourier::rescaleFourier(double maxFreq, double stepFreq)
{
    if (stepFreq > maxFreq || stepFreq != stepFreq || stepFreq < 0)
        return;

    //qDebug() << "rescaleFourier to" << maxFreq << "by" << stepFreq;

    plot->xAxis->setRangeUpper(maxFreq);
    plot->xAxis->setTickStep(maxFreq/10);

    stepFreq = stepFreq > 0 ? stepFreq : -stepFreq;
    xArr->clear();
    for (double i=0; i<maxFreq; i += stepFreq) {
        xArr->append(i);
    }
}

void PlotFourier::slot_processData()
{
    emit sign_fourierPlease();
}

void PlotFourier::slot_continueProcessing()
{
    bars->setData(*xArr, *yArr);
    bars->setWidth(xArr->at(1)-xArr->at(0)-0.1);

    //triggers->analize(bars->data());

    plot->replot();
}

void PlotFourier::slot_triggerTriggered(bool on, TriggerId id)
{
    emit sign_triggerTriggered(signalType, id, on);
}

void PlotFourier::slot_mouseWheel(QWheelEvent *mouseEvent)
{
    if (xArr == nullptr || xArr->size() < 2)
        return;
    if (mouseEvent->delta() < 0 && plot->yAxis->range().upper < 5) {
        plot->yAxis->setRangeUpper(plot->yAxis->range().upper*AXIS_SCALE_RATIO_MORE);
        if (plot->yAxis->range().upper > 5)
            plot->yAxis->setRangeUpper(5);
    }
    else if (mouseEvent->delta() > 0 && plot->yAxis->range().upper > 0.05) {
        plot->yAxis->setRangeUpper(plot->yAxis->range().upper*AXIS_SCALE_RATIO_LESS);
        if (plot->yAxis->range().upper < 0.05)
            plot->yAxis->setRangeUpper(0.05);
    }

    plot->yAxis->setTickStep(plot->yAxis->range().upper /5);
    plot->replot();
}
