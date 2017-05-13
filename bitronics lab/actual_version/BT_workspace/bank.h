#ifndef BANK_H
#define BANK_H

#include <QObject>
#include <QVector>
#include <QDebug>

#include <vector>

#include "qcustomplot.h"
#include "enumeration.h"
#include "plot.h"
#include "plotdiff.h"
#include "plotfourier.h"
#include "datakeeper.h"

using std::vector;

/*!
 * \brief Банк данных
 *
 * Здесь хранятся сырые данные, на основе которых строятся все графики.
 */

class DataBank : public QObject
{
    Q_OBJECT

public:
    DataBank(QObject *parent = 0);
    ~DataBank() = default;

    const QVector<DATA> *getXArr(Channel channel) const;
    const QVector<DATA> *getYArr(Channel channel) const;

    void reset() {
        for (auto it : dataKeepers)
            it.clear();
    }

private:
    DataKeeper dataKeepers[MAX_Y_ARR];

public slots:
    void slot_receiveNewData(Channel destination, DATA key);
    void slot_endOfSession();
    void slot_clear();

};

#endif // BANK_H

