#include "fractalpainter.h"
#include <iostream>
#include <QEvent>
#include <QMouseEvent>
#include <QSize>
#include <math.h>

using namespace std;

QColor FractalPainter::getGoodColor(int iteration)
{
    return colors[iteration % (ColorGradation * 2)];
}

FractalPainter::FractalPainter(QWidget *parent) : QLabel(parent)
{
    setStyleSheet("background: white");
    followRect = Rect(ld(-5.5), ld(-3.3), ld(5.5), ld(3.3));
    currentRect = followRect;
    cout << currentRect.x2 << endl;
    ColorGradation = 128;
    showrect = false;
    select = false;
    selectiondone = false;
    swapped = false;
}

void FractalPainter::paintEvent(QPaintEvent *ev)
{
    cout << "Repaint started!" << endl;
    if (showrect)
    {
        QPainter p;
        p.begin(this);
        p.drawImage(0, 0, *pict);

        if (selectiondone)
        {
            p.setPen(Qt::black);
            p.drawRect(temp.x1-1, temp.y1-1, temp.x2-temp.x1+2, temp.y2-temp.y1+2);
            p.setPen(Qt::white);
            p.drawRect(temp.x1, temp.y1, temp.x2-temp.x1, temp.y2-temp.y1);
        }
        p.end();
    }
    QLabel::paintEvent(ev);
    cout << "Repaint FINITO" << endl;
}

void FractalPainter::CountColours()
{
    colors.clear();
    int yellow_r = 255, yellow_g = 255, yellow_b = 0;
    int blue_r = 27,    blue_g = 12,    blue_b = 74;
    //int yellow_r = 55, yellow_g = 255, yellow_b = 0;
    //int blue_r = 27,    blue_g = 182,    blue_b = 204;
    for (int i = 0; i < 2*ColorGradation; ++i)
        if (i <= ColorGradation)
            colors.push_back(QColor::fromRgb(blue_r + (yellow_r - blue_r)*i/ColorGradation,
                                   blue_g + (yellow_g - blue_g)*i/ColorGradation,
                                   blue_b + (yellow_b - blue_b)*i/ColorGradation));
        else
        {
            int j = i- ColorGradation;
            colors.push_back(QColor::fromRgb(yellow_r + (blue_r - yellow_r)*j/ColorGradation,
                                   yellow_g + (blue_g - yellow_g)*j/ColorGradation,
                                   yellow_b + (blue_b - yellow_b)*j/ColorGradation));
        }
}

void FractalPainter::mousePressEvent(QMouseEvent *ev)
{
    cout << "PressEvent" << endl;
    if (ev->button() == Qt::LeftButton)
    {
        if (!select)
        {
            select = true;
            temp.x1 = ev->x();
            temp.y1 = ev->y();
        }
    }
}

void FractalPainter::mouseReleaseEvent(QMouseEvent *ev)
{
    cout << "ReleaseEvent!"<< endl;
    if (ev->button() == Qt::LeftButton)
    {
        if (select)
        {
            select = false;
            temp.x2 = ev->x();
            temp.y2 = ev->y();
            selectiondone = true;
            RefreshRect();
            sx->setText(QString::number(followRect.x1, 'f'));
            sy->setText(QString::number(followRect.y1, 'f'));
            fx->setText(QString::number(followRect.x2, 'f'));
            fy->setText(QString::number(followRect.y2, 'f'));
        }
    }
    repaint();
}

void FractalPainter::RefreshRect()
{
    int W = this->width(),
        H = this->height();
    int dx = temp.x2 - temp.x1;
    int dy = temp.y2 - temp.y1;
    ld aspectratio = this->width() * 1.0 / this->height();
    ld mustx = dy * aspectratio;
    ld musty = dx * 1.0 / aspectratio;
    if (dx > mustx)
        dy = musty;
    else if (dy > musty)
        dx = mustx;
    dx = abs(dx);
    dy = abs(dy);
    int x1 = temp.x1 - dx;
    int y1 = temp.y1 - dy;
    int x2 = temp.x1 + dx;
    int y2 = temp.y1 + dy;
    temp = Rect(x1, y1, x2, y2);

    followRect = Rect(currentRect.x1 + (currentRect.x2 - currentRect.x1) * x1 * 1.0 / W,
                      currentRect.y1 + (currentRect.y2 - currentRect.y1) * y1 * 1.0 / H,
                      currentRect.x1 + (currentRect.x2 - currentRect.x1) * x2 * 1.0 / W,
                      currentRect.y1 + (currentRect.y2 - currentRect.y1) * y2 * 1.0 / H);
    cout << "for (" << x1<<"; " << y1 << " | " << x2 << "; " << y2 << ") we get (" << followRect.x1 <<"; "<<followRect.y1 << " | " << followRect.x2 << "; " << followRect.y2 << ")" << endl;
}

/*void FractalPainter::mouseMoveEvent(QMouseEvent *ev)
{
    if (ev->button() == Qt::LeftButton)
    {
        if (select)
        {
            temp.x2 = ev->x();
            temp.y2 = ev->y();
            selectiondone = true;
            RefreshRect();
        }
    }
    repaint();
}*/

std::mutex painter_mutex;

void* CalculateThread(void * arg)
{
    ToThreadParams *P = (ToThreadParams *) arg;
    FractalPainter *p = P->fp;
    cout << "Stream started!" << endl;
    int W = p->width(),
        H = p->height();
    for (int yMonitor = P->x; yMonitor < H; yMonitor += 4)
    {
        painter_mutex.lock();
        QRgb *m = (QRgb*) p->pict->scanLine(yMonitor);
        painter_mutex.unlock();
        for (int xMonitor = 0; xMonitor < W; ++xMonitor)
        {
            ld xreal = p->currentRect.x1 + (p->currentRect.x2 - p->currentRect.x1) * xMonitor * 1.0 / W;
            ld yreal = p->currentRect.y1 + (p->currentRect.y2 - p->currentRect.y1) * yMonitor * 1.0 / H;
            Complex z, c;
            if (p->swapped)
            {
                z = Complex(xreal, yreal); c = p->z1;
            }
            else
            {
                z = p->z1; c = Complex(xreal, yreal);
            }
            int iteration = 0;
            Complex f(0.5, 0);
            while (iteration < p->MaxIter && z.Abs2() < p->Infinity)
            {
                z = z/(c+z/(c+(z^2)));
                //z = c/(z + c/(z +c));
                //z = z * z + c;
                //z = z / ((z^2) + z / (c^3));
                //z = (z/(Complex(log(abs(z.x) + 1), -log(abs(z.y) + 1)) - c));
                //z = c*(z^3)/(Complex(sin(z.x)*exp(z.x + 1), sin(z.y)*exp(z.y - 1)));
                //z = c/((z^2) - Complex(sin(z.x*z.x), cos(-1*z.y*z.x)));
                ++iteration;
            }

            painter_mutex.lock();
            if (iteration >= p->MaxIter)
            {
                m[xMonitor] = qRgb(0, 0, 0);
            }
            else
            {
                //p->painter->setPen(p->getGoodColor(iteration));
                m[xMonitor] = p->getGoodColor(iteration).rgb();
            }

            painter_mutex.unlock();
        }
        painter_mutex.lock();
        //p->pb->setValue(p->pb->value()+1);
        painter_mutex.unlock();
        QApplication::processEvents();
    }
}

int FractalPainter::DrawFractal()
{
    Timer timer;
    timer.Start();
    selectiondone = false;
    select = false;
    CountColours();
    currentRect = followRect;
    cout << "NOW DRAWING AT " << currentRect.x1 << "; " << currentRect.y1 << " | " << currentRect.x2 << "; " << currentRect.y2 << endl;
    showrect = true;
    int W = this->width(),
        H = this->height();
    timeinfo->hide();
    pb->setMinimum(0);
    pb->setMaximum(W);
    pb->setValue(0);
    pb->show();
    QApplication::processEvents();

    cout << "Let's draw!" << endl;
    pict = new QImage(QSize(W, H), QImage::Format_ARGB32);
    painter = new QPainter(pict);

    painter->setPen(Qt::black);
    // -----------------------------------------------------
    ToThreadParams p1 = ToThreadParams( this, 0 ),
                   p2 = ToThreadParams( this, 1 ),
                   p3 = ToThreadParams( this, 2 ),
                   p4 = ToThreadParams( this, 3 );
    int result;
    pthread_t thread1, thread2, thread3, thread4;

    result = pthread_create(&thread1, NULL, CalculateThread, &p1);
    if (result != 0) {
        perror("Создание потока 1!");
        return EXIT_FAILURE;
    }
    result = pthread_create(&thread2, NULL, CalculateThread, &p2);
    if (result != 0) {
        perror("Создание потока 2!");
        return EXIT_FAILURE;
    }

    result = pthread_create(&thread3, NULL, CalculateThread, &p3);
    if (result != 0) {
        perror("Создание потока 3!");
        return EXIT_FAILURE;
    }
    result = pthread_create(&thread4, NULL, CalculateThread, &p4);
    if (result != 0) {
        perror("Создание потока 4!");
        return EXIT_FAILURE;
    }


    result = pthread_join(thread1, NULL);
    if (result != 0) {
        perror("Ждём поток 1...");
        return EXIT_FAILURE;
    }
    result = pthread_join(thread2, NULL);
    if (result != 0) {
        perror("Ждём поток 2...");
        return EXIT_FAILURE;
    }
    result = pthread_join(thread3, NULL);
    if (result != 0) {
        perror("Ждём поток 3...");
        return EXIT_FAILURE;
    }
    result = pthread_join(thread4, NULL);
    if (result != 0) {
        perror("Ждём поток 4...");
        return EXIT_FAILURE;
    }

    painter->end();
    cout << "done!" << endl;
    pb->hide();
    timeinfo->show();

    timeinfo->setText(QString("Время последнего вызова: %1").arg(timer.GetTimeFromStart_inms()));
    repaint();
}
