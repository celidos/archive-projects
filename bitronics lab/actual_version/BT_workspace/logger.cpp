#include "logger.h"


Logger::Logger(QObject *parent):QObject(parent)
{}

void Logger::logDataToFile(QString filename)
{
    if (thread_ == NULL)
        initThread();

    emit sign_secondLog(filename);

    needLog = true;
}

void Logger::startLog()
{
    emit sign_firstLog();

    needLog = false;
}

void Logger::setFilename(QString newfilename)
{
    filename = newfilename;
}

void Logger::slot_firstLog()
{
    file.close();
}

void Logger::secondLog(QString filename)
{
    if( *(filename.end()-1) == '/' )
    {
        qDebug() << "Bad path!" << endl;
        filename += "log.txt";
    }
    QDir dir(filename);
    if( !dir.exists() )
    {
        dir.mkpath(dir.path());
        dir.rmdir(dir.path());
    }

    file.setFileName(filename);

    if(!file.open(QIODevice::WriteOnly))
    {
        qDebug() << "Ошибка открытия для записи";
    }

    stream = new QTextStream( &file );

    *stream << yAxesName << endl;
}

void Logger::initThread()
{
    thread_ = new QThread(this);

    this->moveToThread(thread_);

    /// NEED SOME CONNECTIONS

    //connect(thread_, SIGNAL(finished()), logger_, SLOT(deleteLater()));

    thread_->start();
}

void Logger::logIt(double data)
{
    *stream << data << endl;
}
