#ifndef PLOTSIMPLE_H
#define PLOTSIMPLE_H

#include <QObject>
#include <QVector>

#include "qcustomplot.h"
#include "enumeration.h"

const double AXIS_SCALE_RATIO_MORE = 1.25;
const double AXIS_SCALE_RATIO_LESS = 0.8;

const double PLOT_YAXIS_RANGE_MAXIMUM = 5.2; // Вольт
const double PLOT_YAXIS_RANGE_MINIMUM = 0.0; // Вольт

class Plot : public QObject
{
    Q_OBJECT

protected:
    const QVector<DATA> *xArr, *yArr;
    double xRange;

    QCustomPlot *plot; // ui компонента

public:
    explicit Plot(QObject *parent = 0);
    ~Plot() = default;

    virtual void setPlot(QCustomPlot *aimPlot);
    void setSource(const QVector<DATA> *xArr, const QVector<DATA> *yArr);
    void setRange(const int range) { plot->xAxis->setRangeUpper(range);
                                     xRange = range; }
    void setLabel(QLabel *x1, QLabel *x2, QLabel *y1, QLabel *y2) { labelX1 = x1;
                                                                    labelX1->setText("hi");
                                                                    labelX2 = x2;
                                                                    labelY1 = y1;
                                                                    labelY2 = y2; }

    const double &getXRange() const { return xRange; }
    const QVector<DATA> *getXArr() const { return this->xArr; }
    const QVector<DATA> *getYArr() const { return this->yArr; }

    virtual void update();      // принимает данные

signals:
    void sign_nextProcess();  // перестраивает связанный график (фурьер, дифф, etc)
    void sign_label1(double, double);
    void sign_label2(double, double);

public slots:
    void slot_update() { update(); }
    virtual void slot_clear() { plot->graph(0)->clearData(); }
    virtual void slot_mousePressed(QMouseEvent*);
    virtual void slot_mouseMoved(QMouseEvent*);
    virtual void slot_mouseWheel(QWheelEvent*);
    //void slot_draw(QVector<DATA>&,QVector<DATA>*&,size_t); – Реализация отсутствует

protected:
    void findLabels(double, bool);

private:
    void capturePoint(const QPointF &, bool);
    QLabel *labelX1, *labelX2, *labelY1, *labelY2;
};

#endif // PLOTSIMPLE_H

