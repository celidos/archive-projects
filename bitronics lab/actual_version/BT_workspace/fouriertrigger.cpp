#include "fouriertrigger.h"

FourierTrigger::FourierTrigger(QObject *parent):
    QObject(parent),
    bar1(nullptr),
    bar2(nullptr),
    bar3(nullptr),
    source(nullptr)
{}

void FourierTrigger::setSource(QCustomPlot *source)
{
    this->source = source;

    QVector<double> x,y;
    x << 0;
    y << 0;

    bar1 = new QCPBars(source->xAxis, source->yAxis);
    bar1->setData(x,y);
    source->addPlottable(bar1);
    bar1->setPen(QPen(QColor(100, 0, 0)));
    bar1->setBrush(QColor(100, 0, 0, 20));
    bar1->setVisible(false);

    bar2 = new QCPBars(source->xAxis, source->yAxis);
    bar2->setData(x,y);
    source->addPlottable(bar2);
    bar2->setPen(QPen(QColor(0, 100, 0)));
    bar2->setBrush(QColor(100, 0, 0, 20));
    bar2->setVisible(false);

    bar3 = new QCPBars(source->xAxis, source->yAxis);
    bar3->setData(x,y);
    source->addPlottable(bar3);
    bar3->setPen(QPen(QColor(0, 0, 100)));
    bar3->setBrush(QColor(100, 0, 0, 20));
    bar3->setVisible(false);

    qDebug() << "bars are ok!";
}

void FourierTrigger::slot_set1On(bool on)
{
    bar1->setVisible(on);
}

void FourierTrigger::slot_set2On(bool on)
{
    bar2->setVisible(on);
}

void FourierTrigger::slot_set3On(bool on)
{
    bar3->setVisible(on);
}

void FourierTrigger::slot_set1Position(double pos)
{
    QVector<double> x, y;
    x.push_back(pos);
    y.push_back(bar1->data()->isEmpty() ? 0 : bar1->data()->first().value);
    bar1->setData(x,y);
}

void FourierTrigger::slot_set2Position(double pos)
{
    QVector<double> x, y;
    x.push_back(pos);
    y.push_back(bar2->data()->isEmpty() ? 0 : bar2->data()->first().value);
    bar2->setData(x,y);
}

void FourierTrigger::slot_set3Position(double pos)
{
    QVector<double> x, y;
    x.push_back(pos);
    y.push_back(bar3->data()->isEmpty() ? 0 : bar3->data()->first().value);
    bar3->setData(x,y);
}

void FourierTrigger::slot_set1Height(double height)
{
    QVector<double> x, y;
    y.push_back(height);
    x.push_back(bar1->data()->isEmpty() ? 0 : bar1->data()->first().key);
    bar1->setData(x,y);
}

void FourierTrigger::slot_set2Height(double height)
{
    QVector<double> x, y;
    y.push_back(height);
    x.push_back(bar2->data()->isEmpty() ? 0 : bar2->data()->first().key);
    bar2->setData(x,y);
}

void FourierTrigger::slot_set3Height(double height)
{
    QVector<double> x, y;
    y.push_back(height);
    x.push_back(bar3->data()->isEmpty() ? 0 : bar3->data()->first().key);
    bar3->setData(x,y);
}

void FourierTrigger::slot_set1Width(double width)
{
    bar1->setWidth(width);
}

void FourierTrigger::slot_set2Width(double width)
{
    bar2->setWidth(width);
}

void FourierTrigger::slot_set3Width(double width)
{
    bar3->setWidth(width);
}

void FourierTrigger::analize(QCPBarDataMap *data)
{
    bool bars[3], triggers[3]={false, false, false};
    bars[0] = bar1->visible();
    bars[1] = bar2->visible();
    bars[2] = bar3->visible();

    auto Bar1 = bar1->data()->cbegin();
    auto Bar2 = bar2->data()->cbegin();
    auto Bar3 = bar3->data()->cbegin();

    // Узнаём должны ли быть активными триггеры
    auto lastData = data->cend();
    for (auto it = data->cbegin(); (bars[0] || bars[1] || bars[2]) && it!=lastData; ++it) {
        double key = it->key;

        if (bars[0]) {
            if (key > Bar1->key + bar1->width()/2)
                bars[0] = false;
            if (key > Bar1->key - bar1->width()/2 &&
                    it->value > Bar1->value) {
                triggers[0] = true;
                bars[0] = false;
            }
        }

        if (bars[1]) {
            if (key > Bar2->key + bar2->width()/2)
                bars[1] = false;
            if (key > Bar2->key - bar2->width()/2 &&
                    it->value > Bar2->value) {
                triggers[1] = true;
                bars[1] = false;
            }
        }

        if (bars[2]) {
            if (key > Bar3->key + bar3->width()/2)
                bars[2] = false;
            if (key > Bar3->key - bar3->width()/2 &&
                    it->value > Bar3->value) {
                triggers[2] = true;
                bars[2] = false;
            }
        }
    }

    // Делаем выводы
    if (bar1->visible() && triggered[0] != triggers[0]) {
        triggered[0] = triggers[0];
        if (triggered[0])
            bar1->setBrush(QBrush(QColor(0, 100, 0, 40)));
        else
            bar1->setBrush(QBrush(QColor(100, 0, 0, 20)));

        emit sign_triggerTriggered(triggered[0],Trigger1);
    }
    if (bar2->visible() && triggered[1] != triggers[1]) {
        triggered[1] = triggers[1];
        if (triggered[1])
            bar2->setBrush(QBrush(QColor(0, 100, 0, 40)));
        else
            bar2->setBrush(QBrush(QColor(100, 0, 0, 20)));

        emit sign_triggerTriggered(triggered[1], Trigger2);
    }
    if (bar3->visible() && triggered[2] != triggers[2]) {
        triggered[2] = triggers[2];
        if (triggered[2])
            bar3->setBrush(QBrush(QColor(0, 100, 0, 40)));
        else
            bar3->setBrush(QBrush(QColor(100, 0, 0, 20)));

        emit sign_triggerTriggered(triggered[2], Trigger3);
    }
}
