#ifndef PLOTEMG_H
#define PLOTEMG_H

#include "qcustomplot.h"
#include "enumeration.h"
#include "plot.h"

class PlotEMG : public Plot
{
    Q_OBJECT

    bool triggerNeed, isTriggered;
    double triggerPorog, triggerWide;
    QCPGraph *graphUpper, *graphLower;

    void setupTriggers();
    void analize();

public:
    explicit PlotEMG(QObject *parent = 0);
    ~PlotEMG() = default;

    void update();

signals:
    void sign_triggerTriggered(SignalType, TriggerId, bool);

public slots:
    void slot_needTrigger(bool need);
    void slot_setPorog(double porog);
    void slot_setWide(double wide);
};

#endif // PLOTEMG_H
