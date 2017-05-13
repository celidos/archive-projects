#include "plotdiff.h"

PlotDiff::PlotDiff(QObject *parent) : Plot(parent),
    source(nullptr)
{}

void PlotDiff::setPlot(QCustomPlot *aimPlot)
{
    this->plot = aimPlot;

    QCPRange XAxisRange(0, MAX_RANGE);

    plot->addGraph();
    plot->xAxis->setLabel(tr("Время"));
    plot->yAxis->setLabel(tr("Напряжение, В"));
    plot->xAxis->setRange(XAxisRange);
    plot->yAxis->setRange(-PL_DIFF_YAXIS_RANGE_AMPLITUDE, PL_DIFF_YAXIS_RANGE_AMPLITUDE);
    plot->yAxis->setAutoTickStep(false);
    plot->yAxis->setTickStep(1);
    plot->xAxis->setAutoTickStep(false);
    plot->xAxis->setTickStep(int(MAX_RANGE / 1000) * 100);

    plot->replot();
}

void PlotDiff::slot_processData()
{
    const QVector<double> *xArr = source->getXArr(), *yArr = source->getYArr();

    if (yArr->size() < 4)
        return;

    QVector<double> yArrDiff;
    for (int i = 0; i < yArr->size()-3; i++)
    {
        DATA el = (yArr->at(i+1)-yArr->at(i))/(xArr->at(i+1)-xArr->at(i))+
                  (yArr->at(i+2)-yArr->at(i))/(xArr->at(i+2)-xArr->at(i))+
                  (yArr->at(i+3)-yArr->at(i))/(xArr->at(i+3)-xArr->at(i));
        yArrDiff.push_back(el);
    }

    plot->graph(0)->clearData();

    double offset = xArr->last() - source->getXRange();

    for (int i=0; i<yArrDiff.size(); i++)
        plot->graph(0)->addData(xArr->at(i)-offset, yArrDiff.at(i));

    plot->replot();
}

void PlotDiff::slot_mouseWheel(QWheelEvent* ev)
{
    if (xArr == nullptr || xArr->size() < 2)
        return;
    if (plot->yAxis->range().upper - plot->yAxis->range().lower < 100 || ev->delta() > 0) {
        if (ev->delta() < 0)
            plot->yAxis->setRange(plot->yAxis->range().lower*AXIS_SCALE_RATIO_MORE,
                                         plot->yAxis->range().upper*AXIS_SCALE_RATIO_MORE);
        else
            plot->yAxis->setRange(plot->yAxis->range().lower*AXIS_SCALE_RATIO_LESS,
                                         plot->yAxis->range().upper*AXIS_SCALE_RATIO_LESS);
    }

    double tickStep = plot->yAxis->range().upper - plot->yAxis->range().lower;
    if (tickStep/50 > 1)
        plot->yAxis->setTickStep(int(tickStep/50)*10);
    else if (tickStep/5 > 1)
        plot->yAxis->setTickStep(int(tickStep/5));
    else if (10*tickStep/5 > 1)
        plot->yAxis->setTickStep(double(int(10*tickStep/5))/10);
    else if (100*tickStep/5 > 1)
        plot->yAxis->setTickStep(double(int(100*tickStep/5))/100);
    else if (1000*tickStep/5 > 1)
        plot->yAxis->setTickStep(double(int(1000*tickStep/5))/1000);
    plot->replot();
}
