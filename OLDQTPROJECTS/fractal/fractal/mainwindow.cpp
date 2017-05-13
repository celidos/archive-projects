#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <iostream>

using namespace std;

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    QObject::connect(ui->drawButton, SIGNAL(clicked()), this, SLOT(slotDraw()));
    QObject::connect(ui->saveButton, SIGNAL(clicked()), this, SLOT(slotSaveOnDisk()));
    QObject::connect(ui->pushButton, SIGNAL(clicked()), this, SLOT(riseIterUp()));
    QObject::connect(ui->pushButton_2, SIGNAL(clicked()), this, SLOT(riseIterDown()));
    this->fPainter = new FractalPainter;
    cout << "NEWFPAINTER DONE!" << endl;
    ui->verticalLayout->addWidget(fPainter);
    ui->progressBar->hide();
    ui->label_3->hide();
    fPainter->pb = ui->progressBar;
    fPainter->timeinfo = ui->label_3;
    fPainter->sx = ui->startxEdit;
    fPainter->sy = ui->startyEdit;
    fPainter->fx = ui->finishxEdit;
    fPainter->fy = ui->finishyEdit;
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::slotDraw()
{
    fPainter->MaxIter = ui->iterEdit->text().toUInt();
    fPainter->Infinity = ui->infEdit->text().toFloat();
    fPainter->ColorGradation = ui->colorgradEdit->text().toUInt();

    fPainter->z1 = Complex(ui->constxEdit->text().toDouble(), ui->constyEdit->text().toDouble());
    fPainter->z2 = Complex(0, 0);
    if (ui->radioButton_2->isChecked())
        fPainter->swapped = true;
    else
        fPainter->swapped = false;

    this->fPainter->followRect = Rect(ui->startxEdit->text().toDouble(),
                                      ui->startyEdit->text().toDouble(),
                                      ui->finishxEdit->text().toDouble(),
                                      ui->finishyEdit->text().toDouble());
    this->fPainter->DrawFractal();
}


void MainWindow::slotSaveOnDisk()
{
    fPainter->pict->save(ui->lineEdit->text());
}
void MainWindow::riseIterUp()
{
    ui->iterEdit->setText(QString::number(ui->iterEdit->text().toUInt() / 2));
}
void MainWindow::riseIterDown()
{
    ui->iterEdit->setText(QString::number(ui->iterEdit->text().toUInt() * 2));
}
