#include "random.h"

int GetPeriod(int a, int b, int c, int x0)
{
    int t = x0, t1, ans = 0;
    for (int i = 0; i < c; i++)
        t = (a * t + b) % c;
    t1 = t;
    do
    {
        t = (a * t + b) % c;
        ++ans;
    }
    while (t != t1);
    return ans;
}

int GetNonPeriodic(int a, int b, int c, int x0, int l)
{
    int t = x0, m = x0, ans = 0;
    for (int i = 0; i < l; i++)
        t = (a * t + b) % c;
    while (m != t)
    {
        t = (a * t + b) % c;
        m = (a * m + b) % c;
        ++ans;
    }
    return ans;
}

double Quality(int a, int b, int c, int x0, MyCoolWidget *w)
{
    int N = w->lbl->N,
        NUMBER_OF_ELEMENTS = w->NUMBER_OF_ELEMENTS,
        t = x0 % c, *p;
    double quality = 0;
    w->lbl->a = new int [N];
    p = w->lbl->a;
    memset(p, 0, sizeof(int) * N);

    for (int i = 0; i < NUMBER_OF_ELEMENTS; ++i)
    {
        ++(p[t * N / c]);
        t = (a * t + b) % c;
    }
    double temp = 1.0 * NUMBER_OF_ELEMENTS / (1.0 * N);
    for (int i = 0; i < N; i++)
        quality += (p[i] - temp) * (p[i] - temp);

    quality /= ((double)N*N);
    return quality;
}

Label::Label(QWidget *parent): QLabel(parent)
{
    setStyleSheet("background: white");
    m_showRect = false;
}

void Label::showRect()
{
    m_showRect = true;
    repaint();
}

void Label::paintEvent(QPaintEvent *ev)
{
    if (m_showRect)
    {
        int maxx = 0;
        for (int i = 0; i < N; i++)
            if (maxx < a[i])
                maxx = a[i];
        int BORDER_DISTANCE = 10,
            COLOUMN_DISTANCE= 10;
        int COLOUMN_WIDTH   = (width() - 25 - N * COLOUMN_DISTANCE) / N;
        double MAS          = ((double)(height() - 10)) / ((double)maxx);

        QPainter painter(this);
        painter.setPen(Qt::gray);

        int W = width(), H = height();
        if (MAS > 4)
            for (double y = H - BORDER_DISTANCE; y >= 0;  y -= MAS)
                painter.drawLine(0, y, W, y);
        else
            for (double y = H - BORDER_DISTANCE; y >= 0;  y -= MAS*10)
                painter.drawLine(0, y, W, y);
        painter.setPen(Qt::blue);
        painter.setBrush(QColor::fromRgb(qRgb(40, 80, 255)));
        for (int m = 0; m < N; m++)
        {
            int t = m * (COLOUMN_DISTANCE + COLOUMN_WIDTH) + 25;
            painter.drawRect(t, H - BORDER_DISTANCE - (MAS * (double)a[m]), COLOUMN_WIDTH, MAS * (double)a[m]);
        }
    }
    QLabel::paintEvent(ev);
}

MyCoolWidget::MyCoolWidget()
{
    this->Box1 = new QVBoxLayout;
    this->editA = new QLineEdit;
    this->editB = new QLineEdit;
    this->editC = new QLineEdit;
    this->btn1 = new QPushButton ("Calculate!");
    this->lbl = new Label;
    this->editX0 = new QLineEdit;
    this->info = new QLabel;
    Box1->addWidget(editA);
    Box1->addWidget(editB);
    Box1->addWidget(editC);
    Box1->addWidget(editX0);
    Box1->addWidget(btn1);
    Box1->addWidget(info, 0, 0);
    info->setMaximumHeight(20);
    Box1->addWidget(lbl);
    this->setLayout(Box1);
}

void MyCoolWidget::Calculate()
{
    int a, b, c, x0;
    a = this->editA->text().toInt();
    b = this->editB->text().toInt();
    c = this->editC->text().toInt();
    x0 = this->editX0->text().toInt();
    int len = GetPeriod(a, b, c, x0);
    info->setText("  Period = <b>"            + QString::number(len) +
                  "</b>; Non periodic part = <b>" + QString::number(GetNonPeriodic(a, b, c, x0, len)) +
                  "</b>; Quality = <b>"           + QString::number(Quality(a, b, c, x0, this)) +
                  "</b>");
    lbl->showRect();
}
