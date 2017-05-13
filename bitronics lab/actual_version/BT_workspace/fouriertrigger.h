#ifndef FOURIERTRIGGER_H
#define FOURIERTRIGGER_H

#include <QtCore>
#include <QObject>
#include "qcustomplot.h"
#include "enumeration.h"

class FourierTrigger : public QObject
{
    Q_OBJECT

public:
    FourierTrigger(QObject *parent = 0);

    void setSource(QCustomPlot *source);

    void analize(QCPBarDataMap *);

public slots:
    void slot_set1On(bool on);
    void slot_set2On(bool on);
    void slot_set3On(bool on);

    void slot_set1Position(double pos);
    void slot_set2Position(double pos);
    void slot_set3Position(double pos);

    void slot_set1Height(double height);
    void slot_set2Height(double height);
    void slot_set3Height(double height);

    void slot_set1Width(double width);
    void slot_set2Width(double width);
    void slot_set3Width(double width);

signals:
    void sign_triggerTriggered(bool on, TriggerId id);

private:
    bool triggered[3];              // Хранит состояние активности триггеров
    QCPBars *bar1, *bar2, *bar3;    // Хранит данные триггеров в удобном для отрисовки виде
    QCustomPlot *source;            // Источник данных для анализа
};

#endif // FOURIERTRIGGER_H
