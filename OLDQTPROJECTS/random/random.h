#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QLabel>
#include <QPainter>
#include <QPushButton>
#include <QVBoxLayout>
#include <QLineEdit>

class Label : public QLabel
{
    Q_OBJECT
public:
    Label(QWidget* parent = 0);
    virtual void paintEvent(QPaintEvent *ev);
    bool m_showRect;
    int *a;
    const int N = 20;
public slots:
    void showRect();
};

class MyCoolWidget : public QWidget
{
    Q_OBJECT
public:
    const int NUMBER_OF_ELEMENTS = 400;
    QVBoxLayout *Box1;
    QLineEdit *editA;
    QLineEdit *editB;
    QLineEdit *editC;
    QLineEdit *editX0;
    QPushButton *btn1;
    Label *lbl;
    QLabel *info;
    MyCoolWidget();
public slots:
    void Calculate();
};

#endif // MAINWINDOW_H
