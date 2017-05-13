#ifndef FOURIER_H
#define FOURIER_H

#include <QObject>
#include "qcustomplot.h"
#include "enumeration.h"
#include "plotfourier.h"
#include "fft.h"

/*!
 * \brief Класс Фурье
 *
 *
 */

class Fourier : public QObject
{
    Q_OBJECT

    bool mutex;
public:
    explicit Fourier(QObject *parent = 0);

public slots:
    void slot_doFourier(const QVector<double> *source, PlotFourier *aim);

signals:
    void sign_doneFourier();
    void sign_giveSource(SignalType);
};

#endif // FOURIER_H
