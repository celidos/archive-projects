#include "mainwindow.h"

float eps1 = 0.00001;
float eps2 = 0.0001;

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    QObject::connect(ui->pushButton, SIGNAL(clicked()), this, SLOT(Calculate()));
    this->gBuilder = new GraphBuilder;
    ui->verticalLayout->addWidget(gBuilder);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::Calculate()
{
    RefreshEps();
    int x1, y1, x2, y2;
    float a, b;
    a = ui->lineEdit->text().toFloat();
    b = ui->lineEdit_2->text().toFloat();

    x1 = ui->lineEdit_3->text().toInt();
    y1 = ui->lineEdit_4->text().toInt();
    x2 = ui->lineEdit_5->text().toInt();
    y2 = ui->lineEdit_6->text().toInt();

    while (!gBuilder->f.empty())
        gBuilder->f.pop();
    get_rpn(ui->lineEdit_7->text().toStdString(), gBuilder->f);
    //bool ok;
    //ui->label->setText(QString::number(rpn_count(gBuilder->f, 2, ok)));
    //ui->label_2->setText(QString::number(rpn_count(gBuilder->f, 2, ok)));
    gBuilder->DrawGraph(a, b, x1, y1, x2, y2);
}

void MainWindow::RefreshEps()
{
    eps1 = ui->lineEdit_10->text().toFloat();
    eps2 = eps1 * 10;
}
