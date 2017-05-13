#include "graphbuilder.h"

#define EPS 1e-7

GraphBuilder::GraphBuilder(QWidget *parent): QLabel(parent)
{
    setStyleSheet("background: white");
    m_showRect = false;
}

void GraphBuilder::GetMinAndMax()
{
    dx = (b - a) * 1.0f / (x2 - x1);
    bool ok;
    MaxValue = rpn_count(f, a, ok);
    MinValue = MaxValue;
    float FF, Xreal;
    for (int xm = x1; xm <= x2; ++xm)
    {
        Xreal = a + (xm - x1) * dx;
        FF = rpn_count(f, Xreal, ok);
        if (FF > MaxValue) MaxValue = FF;
        if (FF < MinValue) MinValue = FF;
    }

    if (fabs(MaxValue - MinValue) < 1e-6)
    {
        MaxValue += 1.0;
        MinValue -= 1.0;
    }
    MaxValue += 0.1*(MaxValue - MinValue);
    MinValue -= 0.1*(MaxValue - MinValue);
    cout << MinValue << " " << MaxValue << endl;
}

float GraphBuilder::GetCleverGrid(float a, float b)
{
    float gridstep = 1,
          delta = fabs(b - a);

    float order = 1;
    while (order < delta)
        order *= 10;

    while (order > delta)
        order /= 10;

    if (delta / order < 10) order *= 0.5; // 0.1   -> 0.05
    if (delta / order < 10) order *= 0.5; // 0.05  -> 0.025
    if (delta / order < 10) order *= 0.8; // 0.025 -> 0.02
    if (delta / order < 10) order *= 0.5; // 0.02  -> 0.01

    return order;
}

void GraphBuilder::DrawAxises()
{
    painter->setPen(Qt::black);
    int OXm = x1 - a / dx,
        OYm = y2 + MinValue / dy;
    if (OXm >= x1 && OXm <= x2)
        painter->drawLine(OXm, y1, OXm, y2);
    if (OYm >= y1 && OYm <= y2)
        painter->drawLine(x1, OYm, x2, OYm);
}

void GraphBuilder::DrawGrid()
{
    float nearestx = gridstepx * floor(a / gridstepx),
          nearesty = floor(MinValue / gridstepy) * gridstepy;
    QFont font1;
    font1.setPointSize(8);

    painter->setFont(font1);
    float xx = nearestx;
    for (int n = 1; xx < b; xx = nearestx + ((n++) * gridstepx))
    {
        int xm = (xx - a) / dx + x1;
        if (xm >= x1 && xm <= x2)
        {
            painter->setPen(QColor::fromRgb(210, 210, 210));
            painter->drawLine(xm, y1, xm, y2);
            painter->setPen(Qt::black);
            painter->drawText(xm + 2, y2, QString::number(xx));
           }
    }
    float yy = nearesty;
    for (int n = 1; yy < MaxValue; yy = nearesty + ((n++) * gridstepy))
    {
        int ym = y2 - (yy - MinValue) / dy;
        if (ym >= y1 && ym <= y2)
        {
            painter->setPen(QColor::fromRgb(210, 210, 210));
            painter->drawLine(x1, ym, x2, ym);
            painter->setPen(Qt::black);
            painter->drawText(x1, ym - 2, QString::number(yy));
        }
    }
}

void GraphBuilder::DrawFunction()
{
    float Xreal, FF;
    painter->setPen(Qt::blue);
    //cout << "start!" << endl;
    bool olo;
    int lasty = y2 - (rpn_count(f, a, olo) - MinValue) / dy,
        ym;

    for (int xm = x1 + 1; xm <= x2; ++xm)
    {
        //cout << x1 << " / " << xm << " / " << x2 << endl;
        Xreal = a + (xm - x1) * dx;
        bool ok;
        FF = rpn_count(f, Xreal*1.0, ok);
        ym = y2 - floor((FF - MinValue) / dy );


        if (ok)
            painter->drawLine(xm - 1, lasty, xm, ym);
        lasty = ym;
    }
}

void GraphBuilder::DrawGraph(float A, float B, int X1, int Y1, int X2, int Y2)
{
    m_showRect = true;
    a = A;
    b = B;
    pict = new QPicture;
    x1 = X1;
    y1 = Y1;
    x2 = X2;
    y2 = Y2;

    painter = new QPainter(pict);
    painter->setPen(Qt::gray);
    painter->drawRect(x1, y1, x2 - x1, y2 - y1);

    GetMinAndMax();

    dy = (MaxValue - MinValue) / (y2 - y1);

    gridstepx = GetCleverGrid(a, b);
    gridstepy = GetCleverGrid(MinValue, MaxValue);

    DrawGrid();
    DrawAxises();
    DrawFunction();

    //this->setText(QString::number(gridstepy));
    painter->end();
    repaint();
}

void GraphBuilder::paintEvent(QPaintEvent *ev)
{
    if (m_showRect)
    {
        QPainter p;
        p.begin(this);
        p.drawPicture(0, 0, *pict);
        p.end();
        pict->save("drawing.bmp");
    }
    QLabel::paintEvent(ev);
}
