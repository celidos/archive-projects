#ifndef LOGGER_H
#define LOGGER_H

#include <QObject>
#include <qcustomplot.h>

class Logger : public QObject
{
    Q_OBJECT
public:
    explicit Logger(QObject *parent = 0);

    bool needLog = false;

    void logDataToFile(QString filename);
    void startLog();
    void setFilename (QString newfilename);

signals:
    void sign_firstLog();
    void sign_secondLog(QString);

public slots:
    void slot_firstLog();
    void logIt(double);
    void secondLog(QString);

private:
    QFile file;
    QTextStream *stream;
    const char *xAxesName = "time";
    const char *yAxesName = "value";

    QThread* thread_ = NULL;
    QString filename;
    void initThread();              /// NOT OK, NEED CONNECTIONS
};

#endif // LOGGER_H
