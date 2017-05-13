#include "fourier.h"


Fourier::Fourier(QObject *parent) : QObject(parent), mutex(true)
{}

void Fourier::slot_doFourier(const QVector<double> *source, PlotFourier *aim)
{
    ShortComplex *data = new ShortComplex[source->size()];

    for (int i = 0; i < source->size(); ++i) {
        data[i].re = source->at(i);
        data[i].im = 0.0;
    }

    int N = source->size();

    universal_fft(data, N, false);

    int i;

    //убираем зеркальный эффект, просто отбрасывая вторую половину
    int Nmax = (N + 1) / 2;

    // Амплитуды
    double *amp= new double[Nmax];

    int j = 0;
    double limit= 0.00001;

    //получаем постоянную составляющую
    if (data[i].re >= limit)
    {
        amp[j]= data[i].re / N;
        ++j;
    }
    ++i;

    //получаем остальные гармоники
    for (i = 1; i < Nmax; ++i)
    {
        double re = data[i].re;
        double im = data[i].im;

        //это квадрат модуля комплексного числа arr[i]
        double abs2 = re * re + im * im;

        //вычисляем апмлитуду. 2.0 - для устранения зеркального эффекта
        amp[j]= 2.0 * sqrt(abs2) / N;

        ++j;
    }

    // -----------------------------------

    QVector<double> &yArr = aim->getYArr();

    yArr.clear();
    for (int i = 0; i < j; i++) {
        yArr.push_back(amp[i]);
    }

    qDebug() << "size = " << yArr.size();

    aim->slot_continueProcessing();
}
