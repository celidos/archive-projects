#ifndef ALARMDIALOG_H
#define ALARMDIALOG_H

#include <QDialog>

namespace Ui {
class AlarmDialog;
}

class AlarmDialog : public QDialog
{
    Q_OBJECT

public:
    explicit AlarmDialog(QWidget *parent = 0);
    ~AlarmDialog();

private:
    Ui::AlarmDialog *ui;

public slots:
    void ok_now_close();
};

#endif // ALARMDIALOG_H
