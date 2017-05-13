#include "vidcap.h"

Vidcap::Vidcap(CvCapture *cap)
{
    capture = cap;
    stopped = false;
}

void Vidcap::run()
{
    forever {
        {
            QMutexLocker locker(&mutex);
            if (stopped) {
                stopped = false;
                break;
            }
        }
        IplImage *frame = cvQueryFrame(capture);
        emit redy(frame);
    }
}

void Vidcap::stop()
{
    QMutexLocker locker(&mutex);
    stopped = true;
}

void Vidcap::setSize(FrameSize)
{
    cvSetCaptureProperty(capture, CV_CAP_PROP_FRAME_WIDTH, sizeWH.width);
    cvSetCaptureProperty(capture, CV_CAP_PROP_FRAME_HEIGHT, sizeWH.height);
}
