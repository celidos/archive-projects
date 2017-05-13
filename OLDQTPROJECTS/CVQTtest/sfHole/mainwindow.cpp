#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QLabel>
//#include <QDebug>

/* Взято с http://www.developer.nokia.com/Community/Wiki/Using_OpenCV_with_Qt
 * конвертируем данные из формата IplImage в формат QImage */

static QImage IplImage2QImage(const IplImage *iplImage)
{
    int height = iplImage->height;
    int width = iplImage->width;

    if  (iplImage->depth == IPL_DEPTH_8U && iplImage->nChannels == 3)
    {
        const uchar *qImageBuffer = (const uchar*)iplImage->imageData;
        QImage img(qImageBuffer, width, height, QImage::Format_RGB888);
        return img.rgbSwapped();
    } else if  (iplImage->depth == IPL_DEPTH_8U && iplImage->nChannels == 1){
        const uchar *qImageBuffer = (const uchar*)iplImage->imageData;
        QImage img(qImageBuffer, width, height, QImage::Format_Indexed8);

        QVector<QRgb> colorTable;
        for (int i = 0; i < 256; i++){
            colorTable.push_back(qRgb(i, i, i));
        }
        img.setColorTable(colorTable);
        return img;
    }else{
       // qWarning() << "Image cannot be converted.";
        return QImage();
    }
}

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    c = NULL;
    ui->setupUi(this);
    createMyThread();
}

/* Создаём и запускаем поток, который работает с web-камерой.
 * Устанавливаем размер кадра 640*480 точек.
 * Подключаем сигнал redy к слоту ShowNewFrame.
 */

void MainWindow::createMyThread()
{
   c = cvCreateCameraCapture(CV_CAP_ANY);
    if (c != NULL) {
        vidcap = new Vidcap(c);
        FrameSize sizeWH;
        sizeWH.width = 640;
        sizeWH.height = 480;
        vidcap->setSize(sizeWH);
        connect(vidcap, SIGNAL(redy(IplImage *)), this, SLOT(ShowNewFrame(IplImage *)));
        vidcap->start();
    }
    else {
        ui->label->setText("Video device not found.");
    }
}

/* Слот обновляющий изображение на метке */

void MainWindow::ShowNewFrame(IplImage *frame)
{
    ui->label->setPixmap(QPixmap::fromImage(IplImage2QImage(frame)));
}

MainWindow::~MainWindow()
{
    if (c != NULL) {
        vidcap->stop();
        vidcap->wait();
        cvReleaseCapture(&c);
    }

    delete ui;
}
