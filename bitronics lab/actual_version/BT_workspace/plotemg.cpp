#include "plotemg.h"

PlotEMG::PlotEMG(QObject *parent) :
    Plot(parent),
    triggerNeed(false),
    isTriggered(false),
    triggerPorog(0),
    triggerWide(0),
    graphUpper(nullptr),
    graphLower(nullptr)
{}

void PlotEMG::setupTriggers()
{
    graphUpper = plot->addGraph();
    graphLower = plot->addGraph();

    graphUpper->setBrush(QBrush(QColor(100, 0, 0, 20)));
    graphUpper->setChannelFillGraph(graphLower);
    graphUpper->setPen(QPen(QColor(100, 0, 0)));
    graphLower->setPen(QPen(QColor(100, 0, 0)));

    graphUpper->setVisible(false);
    graphLower->setVisible(false);

    QVector<double> x, y;
    x.append(xRange - triggerWide);
    x.append(xRange);
    y.append(2.5 + triggerPorog/2);
    y.append(2.5 + triggerPorog/2);
    graphUpper->setData(x, y);

    y[0] -= triggerPorog;
    y[1] -= triggerPorog;
    graphLower->setData(x, y);
}

void PlotEMG::analize()
{
    auto itX = xArr->cend()-1;
    auto itY = yArr->cend()-1;

    double stop  = xArr->last() - triggerWide;
    double max = *itY, min = *itY;
    for (; itX != xArr->cbegin() && *itX > stop; itX--, itY--) {
        if (*itY < min)
            min = *itY;
        if (*itY > max)
            max = *itY;
    }

    bool currentTrigger = (max - min > triggerPorog);

    if (currentTrigger != isTriggered) {
        isTriggered = currentTrigger;
        if (isTriggered) {
            graphUpper->setBrush(QBrush(QColor(0, 100, 0, 40)));
            graphUpper->setPen(QPen(QColor(0, 100, 0)));
            graphLower->setPen(QPen(QColor(0, 100, 0)));
        }
        else {
            graphUpper->setBrush(QBrush(QColor(100, 0, 0, 40)));
            graphUpper->setPen(QPen(QColor(100, 0, 0)));
            graphLower->setPen(QPen(QColor(100, 0, 0)));
        }
        emit sign_triggerTriggered(EMG, Trigger0, isTriggered);
    }
}

void PlotEMG::update()
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

    if (triggerNeed)
        analize();

    if (!plot->graph(1)->data()->isEmpty())
        findLabels(plot->graph(1)->data()->first().key, true);
    if (!plot->graph(2)->data()->isEmpty())
        findLabels(plot->graph(2)->data()->first().key, false);

    plot->replot();

    emit sign_nextProcess();
}

void PlotEMG::slot_needTrigger(bool need)
{
    triggerNeed = need;

    if (graphLower == nullptr)
        setupTriggers();

    graphUpper->setVisible(need);
    graphLower->setVisible(need);
}

void PlotEMG::slot_setPorog(double porog)
{
    triggerPorog = porog;

    QVector<double> x, y;
    x.append(xRange - triggerWide);
    x.append(xRange);
    y.append(2.5 + porog/2);
    y.append(2.5 + porog/2);
    graphUpper->setData(x, y);

    y[0] -= porog;
    y[1] -= porog;
    graphLower->setData(x, y);
}

void PlotEMG::slot_setWide(double wide)
{
    triggerWide = wide;

    QVector<double> x, y;
    x.append(xRange - triggerWide);
    x.append(xRange);
    y.append(2.5 + triggerPorog/2);
    y.append(2.5 + triggerPorog/2);
    graphUpper->setData(x, y);

    y[0] -= triggerPorog;
    y[1] -= triggerPorog;
    graphLower->setData(x, y);
}
