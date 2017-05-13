#ifndef VIDCAP_H
#define VIDCAP_H
#include <QThread>
#include <QMutex>

#include <opencv/cv.h>
#include <opencv/highgui.h>

struct FrameSize {
    int width;
    int height;
};

class Vidcap : public QThread
{
    Q_OBJECT

public:
    Vidcap(CvCapture * cap);
    void stop();
    void setSize(FrameSize);

signals:
    void redy(IplImage *);

protected:
    void run();

private:
    CvCapture *capture;
    volatile bool stopped;
    QMutex mutex;
    FrameSize sizeWH;
};

#endif // VIDCAP_H
