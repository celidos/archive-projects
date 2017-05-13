#include "mainwindow.h"

float eps1 = 0.00001;
float eps2 = 0.0001;

float f1(float x, float y)
{
    //return 1.0 / ((y + 2.0)*sqrt(log(y + 2.0)));
    //return -0.5*x-1;//0.01*x*x + 0.01*y*y - x;
    return exp(y * x);
}

float function(float x)
{
    return (x*(2-x)*Integral(f1, -10, 1, x, eps1) - 0.5) * (0.01);
}

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    QObject::connect(ui->pushButton, SIGNAL(clicked()), this, SLOT(Calculate()));
    QObject::connect(ui->pushButton_2, SIGNAL(clicked()), this, SLOT(CopyEditValues()));
    QObject::connect(ui->pushButton_3, SIGNAL(clicked()), this, SLOT(Solve()));
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
    ui->label_2->setText("<p style=""color:red"">[not defined]</p>");
cout << "ok!\n";
    int x1, y1, x2, y2;
    float a, b;
    a = ui->lineEdit->text().toFloat();
    b = ui->lineEdit_2->text().toFloat();

    x1 = ui->lineEdit_3->text().toInt();
    y1 = ui->lineEdit_4->text().toInt();
    x2 = ui->lineEdit_5->text().toInt();
    y2 = ui->lineEdit_6->text().toInt();

    gBuilder->DrawGraph(a, b, x1, y1, x2, y2, function);
}

void MainWindow::CopyEditValues()
{
    ui->lineEdit_7->setText(ui->lineEdit  ->text());
    ui->lineEdit_8->setText(ui->lineEdit_2->text());
}

void MainWindow::Solve()
{
    RefreshEps();
    ui->label_2->setText("<p style=""color:red"">[not defined]</p>");
    float a, b, sp, solution;
    a = ui->lineEdit_7->text().toFloat();
    b = ui->lineEdit_8->text().toFloat();
    sp= ui->lineEdit_9->text().toFloat();
    solution = gBuilder->Solve(a, b, sp, eps2, function);

    ui->label_2->setText("<p style=""color:black"">" +
                         QString::number(solution) +
                         ";  delta = " +
                         QString::number(function(solution)) + "</p>");
}

void MainWindow::RefreshEps()
{
    eps1 = ui->lineEdit_10->text().toFloat();
    eps2 = eps1 * 10;
}
