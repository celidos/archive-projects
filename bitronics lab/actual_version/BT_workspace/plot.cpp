#include "plot.h"

Plot::Plot(QObject *parent):
    QObject(parent),
    xArr(nullptr),
    yArr(nullptr),
    xRange(MAX_RANGE),
    plot(nullptr)
{
    // If you ADD something there, be sure that will not DAMAGE PlotFourier and PlotDiff!
}

void Plot::setPlot(QCustomPlot *aimPlot)
{
    plot = aimPlot;

    QCPRange XAxisRange(0, xRange);
    QCPRange YAxisRange(PLOT_YAXIS_RANGE_MINIMUM, PLOT_YAXIS_RANGE_MAXIMUM);

    for (size_t i = 0; i < 3; i++)
        plot->addGraph();

    plot->xAxis->setLabel(tr("Время"));
    plot->yAxis->setLabel(tr("Напряжение, В"));
    plot->xAxis->setRange(XAxisRange);
    plot->yAxis->setRange(YAxisRange);
    plot->yAxis->setAutoTickStep(false);
    plot->yAxis->setTickStep(1);
    plot->xAxis->setAutoTickStep(false);
    plot->xAxis->setTickStep(2);

    plot->graph(1)->setPen(QPen(QColor(51, 204, 51)));
    plot->graph(2)->setPen(QPen(QColor(51, 51, 204)));
    plot->graph(1)->setVisible(false);
    plot->graph(2)->setVisible(false);

    connect(plot, SIGNAL(mousePress(QMouseEvent*)), this, SLOT(slot_mousePressed(QMouseEvent*)));
    connect(plot, SIGNAL(mouseMove(QMouseEvent*)), this, SLOT(slot_mouseMoved(QMouseEvent*)));
    connect(plot, SIGNAL(mouseWheel(QWheelEvent*)), this, SLOT(slot_mouseWheel(QWheelEvent*)));

    plot->replot();
}

void Plot::setSource(const QVector<DATA> *xArr, const QVector<DATA> *yArr)
{
    this->xArr = xArr;
    this->yArr = yArr;
}

void Plot::update()
{
    if (xArr->isEmpty() || yArr->isEmpty())
        return;

    plot->graph(0)->clearData();

    double offset = xArr->last() - xRange;

    if (xArr->size() < 1000)
        for (int i = 0; i<xArr->size(); i++)
            plot->graph(0)->addData(xArr->at(i)-offset, yArr->at(i));
    else {
        auto itX = xArr->cend(), itY = yArr->cend();
        int inc = int(xRange/(*(itX) - *(itX-1000))) > 0 ? int(xRange/(*(itX) - *(itX-1000))) : 1;
        for (int i = 0; i < xArr->size()/inc; itX -= inc, itY -= inc, i++ )
            plot->graph(0)->addData(*(itX) - offset, *itY);
    }

    if (!plot->graph(1)->data()->isEmpty())
        findLabels(plot->graph(1)->data()->first().key, true);
    if (!plot->graph(2)->data()->isEmpty())
        findLabels(plot->graph(2)->data()->first().key, false);

    plot->replot();

    emit sign_nextProcess();
}

void Plot::slot_mousePressed(QMouseEvent *mouse)
{
    if( mouse->button() == Qt::MouseButton::LeftButton )
        capturePoint(mouse->localPos(), true);
    if( mouse->button() == Qt::MouseButton::RightButton )
        capturePoint(mouse->localPos(), false);
}

void Plot::slot_mouseMoved(QMouseEvent *mouse){
    if ((mouse->buttons() & Qt::LeftButton) == Qt::LeftButton)
        capturePoint(mouse->localPos(), true);
    if ((mouse->buttons() & Qt::RightButton) == Qt::RightButton)
        capturePoint(mouse->localPos(), false);
}

void Plot::slot_mouseWheel(QWheelEvent *mouseEvent)
{
    if (xArr == nullptr || xArr->size() < 2)
        return;

    if (mouseEvent->delta() < 0 && plot->xAxis->range().upper - plot->xAxis->range().lower < MAX_RANGE) {
        plot->xAxis->setRangeUpper(plot->xAxis->range().upper*AXIS_SCALE_RATIO_MORE);
        if (plot->xAxis->range().upper - plot->xAxis->range().lower > MAX_RANGE)
            plot->xAxis->setRangeUpper(MAX_RANGE);
    }
    else if (mouseEvent->delta() > 0 && plot->xAxis->range().upper - plot->xAxis->range().lower > 10*(xArr->at(1) - xArr->at(0)) ) {
        plot->xAxis->setRangeUpper(plot->xAxis->range().upper*AXIS_SCALE_RATIO_LESS);
        if (plot->xAxis->range().upper - plot->xAxis->range().lower < 10*(xArr->at(1) - xArr->at(0)))
            plot->xAxis->setRangeUpper(10*(xArr->at(1) - xArr->at(0)));
    }

    xRange = plot->xAxis->range().upper;

    plot->xAxis->setTickStep(xRange/10);
    plot->replot();
}

void Plot::capturePoint(const QPointF &pos, bool first)
{
    if (xArr == nullptr)
        return;

    QVector<double> x, y;

    x.append(plot->xAxis->pixelToCoord(pos.x()));
    x.append(x.at(0));

    y.clear();
    y.append(plot->yAxis->range().lower);
    y.append(plot->yAxis->range().upper);

    if (first) {
        plot->graph(1)->setData(x, y);
        plot->graph(1)->setVisible(true);
    }
    else {
        plot->graph(2)->setData(x, y);
        plot->graph(2)->setVisible(true);
    }

    findLabels(x.at(0), first);

    plot->replot();
}

void Plot::findLabels(double x, bool first)
{    if (first) {
        if ( x > 0 && x < plot->xAxis->range().upper ) {
            auto it = xArr->cbegin(), value = yArr->cbegin();
            for (auto end = xArr->cend()-1; it != end && *it < x - plot->xAxis->range().upper + *(end-1); it++, value++);
            emit sign_label1(x, *value);
        }
    }
    else {
        if ( x > 0 && x < plot->xAxis->range().upper ) {
            auto it = xArr->cbegin(), value = yArr->cbegin();
            for (auto end = xArr->cend()-1; it != end && *it < x - plot->xAxis->range().upper + *(end-1); it++, value++);
            emit sign_label2(x, *value);
        }
    }
}
