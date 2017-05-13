#ifndef FRACTALPAINTER_H
#define FRACTALPAINTER_H

#include <QMainWindow>
#include <QApplication>
#include <QObject>
#include <QLabel>
#include <QPainter>
#include <QVBoxLayout>
#include <QPicture>
#include <QColor>
#include <QProgressBar>
#include <math.h>
#include <vector>
#include <thread>
#include <mutex>
#include <QLineEdit>
#include "timerwork.h"
#include "complex.hpp"

typedef long double ld;
using namespace std;

class FractalPainter;

struct Rect
{
    ld x1, y1, x2, y2;
    Rect(ld X1, ld Y1, ld X2, ld Y2)
    {
        x1 = X1; y1 = Y1; x2 = X2; y2 = Y2;
    };
    Rect()
    {

    };
};

struct ToThreadParams
{
    FractalPainter *fp;
    int x;
    ToThreadParams(FractalPainter *FractalPainter, int X)
    {
        fp = FractalPainter;
        x = X;
    };
};

class FractalPainter : public QLabel
{
    Q_OBJECT
public:
    FractalPainter(QWidget* parent = 0);
    virtual void paintEvent(QPaintEvent *ev);
    void mousePressEvent(QMouseEvent *ev);
    void mouseReleaseEvent(QMouseEvent *ev);

    bool showrect;

    Rect currentRect;
    Rect followRect;
    Rect temp;

    unsigned int MaxIter;
    ld Infinity;
    int ColorGradation;
    QProgressBar *pb;
    QLabel *timeinfo;
    QImage *pict;
    QPainter *painter;
    bool select;
    bool selectiondone;
    Complex z1;
    Complex z2;
    bool swapped;

    QLineEdit *sx;
    QLineEdit *sy;
    QLineEdit *fx;
    QLineEdit *fy;

    QColor getGoodColor(int iteration);
    void RefreshRect();
    void CountColours();
private:
    vector <QColor> colors;
public slots:
    int DrawFractal();
};

#endif // FRACTALPAINTER_H
