#ifndef GRAPHBUILDER_H
#define GRAPHBUILDER_H

#include <QMainWindow>
#include <QObject>
#include <QLabel>
#include <QPainter>
#include <QVBoxLayout>
#include <QPicture>
#include <math.h>
#include <iostream>

#include "polish_notation.h"

using namespace std;

typedef float (*ffp1f)(float);

class GraphBuilder : public QLabel
{
    Q_OBJECT
public:
    GraphBuilder(QWidget* parent = 0);
    virtual void paintEvent(QPaintEvent *ev);

    bool m_showRect;
    int x1;
    int y1;
    int x2;
    int y2;
    float a;
    float b;
    float MinValue;
    float MaxValue;
    float dx;
    float dy;
    float gridstepx;
    float gridstepy;
    QPicture *pict;
    QPainter *painter;
    stack <rpn_stack_elem> f;

private:
    void GetMinAndMax();
    float GetCleverGrid(float a, float b);
    void DrawAxises();
    void DrawGrid();
    void DrawFunction();
public slots:
    void DrawGraph(float A, float B, int X1, int Y1, int X2, int Y2);
};

#endif // GRAPHBUILDER_H
