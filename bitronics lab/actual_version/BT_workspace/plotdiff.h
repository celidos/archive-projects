#ifndef PLOTDIFF_H
#define PLOTDIFF_H

#include "plot.h"
#include "qcustomplot.h"

const double PL_DIFF_YAXIS_RANGE_AMPLITUDE = 0.4; // Вольт

class PlotDiff : public Plot
{
    Q_OBJECT

public:
    explicit PlotDiff(QObject *parent = 0);
    void setSource(const Plot *source) {
        this->source = source;
        connect(source, SIGNAL(sign_nextProcess()),
                this, SLOT(slot_processData()));
    }
    void setPlot(QCustomPlot *aimPlot);

private:
    const Plot *source;
    double xRange;

signals:
    void sign_nextProcess(QVector<DATA>&, QVector<DATA>&);

public slots:
    virtual void slot_mouseWheel(QWheelEvent* ev);
    void slot_processData();
};

#endif // PLOTDIFF_H

