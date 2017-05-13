#include "alarmdialog.h"
#include "ui_alarmdialog.h"

AlarmDialog::AlarmDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::AlarmDialog)
{
    ui->setupUi(this);

    QObject::connect(ui->pushButton, SIGNAL(clicked()), this, SLOT(ok_now_close()));
}

AlarmDialog::~AlarmDialog()
{
    delete ui;
}

void AlarmDialog::ok_now_close()
{
    this->close();
}
