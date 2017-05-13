/****************************************************************************
** Meta object code from reading C++ file 'QXmppStun.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.2.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "base/QXmppStun.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'QXmppStun.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.2.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_QXmppStunTransaction_t {
    QByteArrayData data[9];
    char stringdata[91];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    offsetof(qt_meta_stringdata_QXmppStunTransaction_t, stringdata) + ofs \
        - idx * sizeof(QByteArrayData) \
    )
static const qt_meta_stringdata_QXmppStunTransaction_t qt_meta_stringdata_QXmppStunTransaction = {
    {
QT_MOC_LITERAL(0, 0, 20),
QT_MOC_LITERAL(1, 21, 8),
QT_MOC_LITERAL(2, 30, 0),
QT_MOC_LITERAL(3, 31, 9),
QT_MOC_LITERAL(4, 41, 16),
QT_MOC_LITERAL(5, 58, 7),
QT_MOC_LITERAL(6, 66, 8),
QT_MOC_LITERAL(7, 75, 8),
QT_MOC_LITERAL(8, 84, 5)
    },
    "QXmppStunTransaction\0finished\0\0writeStun\0"
    "QXmppStunMessage\0request\0readStun\0"
    "response\0retry\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QXmppStunTransaction[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   34,    2, 0x06,
       3,    1,   35,    2, 0x06,

 // slots: name, argc, parameters, tag, flags
       6,    1,   38,    2, 0x0a,
       8,    0,   41,    2, 0x08,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 4,    5,

 // slots: parameters
    QMetaType::Void, 0x80000000 | 4,    7,
    QMetaType::Void,

       0        // eod
};

void QXmppStunTransaction::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QXmppStunTransaction *_t = static_cast<QXmppStunTransaction *>(_o);
        switch (_id) {
        case 0: _t->finished(); break;
        case 1: _t->writeStun((*reinterpret_cast< const QXmppStunMessage(*)>(_a[1]))); break;
        case 2: _t->readStun((*reinterpret_cast< const QXmppStunMessage(*)>(_a[1]))); break;
        case 3: _t->retry(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (QXmppStunTransaction::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QXmppStunTransaction::finished)) {
                *result = 0;
            }
        }
        {
            typedef void (QXmppStunTransaction::*_t)(const QXmppStunMessage & );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QXmppStunTransaction::writeStun)) {
                *result = 1;
            }
        }
    }
}

const QMetaObject QXmppStunTransaction::staticMetaObject = {
    { &QXmppLoggable::staticMetaObject, qt_meta_stringdata_QXmppStunTransaction.data,
      qt_meta_data_QXmppStunTransaction,  qt_static_metacall, 0, 0}
};


const QMetaObject *QXmppStunTransaction::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QXmppStunTransaction::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QXmppStunTransaction.stringdata))
        return static_cast<void*>(const_cast< QXmppStunTransaction*>(this));
    return QXmppLoggable::qt_metacast(_clname);
}

int QXmppStunTransaction::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QXmppLoggable::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 4;
    }
    return _id;
}

// SIGNAL 0
void QXmppStunTransaction::finished()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void QXmppStunTransaction::writeStun(const QXmppStunMessage & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
struct qt_meta_stringdata_QXmppTurnAllocation_t {
    QByteArrayData data[18];
    char stringdata[212];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    offsetof(qt_meta_stringdata_QXmppTurnAllocation_t, stringdata) + ofs \
        - idx * sizeof(QByteArrayData) \
    )
static const qt_meta_stringdata_QXmppTurnAllocation_t qt_meta_stringdata_QXmppTurnAllocation = {
    {
QT_MOC_LITERAL(0, 0, 19),
QT_MOC_LITERAL(1, 20, 9),
QT_MOC_LITERAL(2, 30, 0),
QT_MOC_LITERAL(3, 31, 16),
QT_MOC_LITERAL(4, 48, 4),
QT_MOC_LITERAL(5, 53, 12),
QT_MOC_LITERAL(6, 66, 4),
QT_MOC_LITERAL(7, 71, 4),
QT_MOC_LITERAL(8, 76, 12),
QT_MOC_LITERAL(9, 89, 13),
QT_MOC_LITERAL(10, 103, 18),
QT_MOC_LITERAL(11, 122, 9),
QT_MOC_LITERAL(12, 132, 7),
QT_MOC_LITERAL(13, 140, 15),
QT_MOC_LITERAL(14, 156, 19),
QT_MOC_LITERAL(15, 176, 9),
QT_MOC_LITERAL(16, 186, 16),
QT_MOC_LITERAL(17, 203, 7)
    },
    "QXmppTurnAllocation\0connected\0\0"
    "datagramReceived\0data\0QHostAddress\0"
    "host\0port\0disconnected\0connectToHost\0"
    "disconnectFromHost\0readyRead\0refresh\0"
    "refreshChannels\0transactionFinished\0"
    "writeStun\0QXmppStunMessage\0message\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QXmppTurnAllocation[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   64,    2, 0x06,
       3,    3,   65,    2, 0x06,
       8,    0,   72,    2, 0x06,

 // slots: name, argc, parameters, tag, flags
       9,    0,   73,    2, 0x0a,
      10,    0,   74,    2, 0x0a,
      11,    0,   75,    2, 0x08,
      12,    0,   76,    2, 0x08,
      13,    0,   77,    2, 0x08,
      14,    0,   78,    2, 0x08,
      15,    1,   79,    2, 0x08,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::QByteArray, 0x80000000 | 5, QMetaType::UShort,    4,    6,    7,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 16,   17,

       0        // eod
};

void QXmppTurnAllocation::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QXmppTurnAllocation *_t = static_cast<QXmppTurnAllocation *>(_o);
        switch (_id) {
        case 0: _t->connected(); break;
        case 1: _t->datagramReceived((*reinterpret_cast< const QByteArray(*)>(_a[1])),(*reinterpret_cast< const QHostAddress(*)>(_a[2])),(*reinterpret_cast< quint16(*)>(_a[3]))); break;
        case 2: _t->disconnected(); break;
        case 3: _t->connectToHost(); break;
        case 4: _t->disconnectFromHost(); break;
        case 5: _t->readyRead(); break;
        case 6: _t->refresh(); break;
        case 7: _t->refreshChannels(); break;
        case 8: _t->transactionFinished(); break;
        case 9: _t->writeStun((*reinterpret_cast< const QXmppStunMessage(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (QXmppTurnAllocation::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QXmppTurnAllocation::connected)) {
                *result = 0;
            }
        }
        {
            typedef void (QXmppTurnAllocation::*_t)(const QByteArray & , const QHostAddress & , quint16 );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QXmppTurnAllocation::datagramReceived)) {
                *result = 1;
            }
        }
        {
            typedef void (QXmppTurnAllocation::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QXmppTurnAllocation::disconnected)) {
                *result = 2;
            }
        }
    }
}

const QMetaObject QXmppTurnAllocation::staticMetaObject = {
    { &QXmppLoggable::staticMetaObject, qt_meta_stringdata_QXmppTurnAllocation.data,
      qt_meta_data_QXmppTurnAllocation,  qt_static_metacall, 0, 0}
};


const QMetaObject *QXmppTurnAllocation::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QXmppTurnAllocation::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QXmppTurnAllocation.stringdata))
        return static_cast<void*>(const_cast< QXmppTurnAllocation*>(this));
    return QXmppLoggable::qt_metacast(_clname);
}

int QXmppTurnAllocation::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QXmppLoggable::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 10)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 10;
    }
    return _id;
}

// SIGNAL 0
void QXmppTurnAllocation::connected()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void QXmppTurnAllocation::datagramReceived(const QByteArray & _t1, const QHostAddress & _t2, quint16 _t3)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void QXmppTurnAllocation::disconnected()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}
struct qt_meta_stringdata_QXmppIceComponent_t {
    QByteArrayData data[19];
    char stringdata[219];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    offsetof(qt_meta_stringdata_QXmppIceComponent_t, stringdata) + ofs \
        - idx * sizeof(QByteArrayData) \
    )
static const qt_meta_stringdata_QXmppIceComponent_t qt_meta_stringdata_QXmppIceComponent = {
    {
QT_MOC_LITERAL(0, 0, 17),
QT_MOC_LITERAL(1, 18, 9),
QT_MOC_LITERAL(2, 28, 0),
QT_MOC_LITERAL(3, 29, 16),
QT_MOC_LITERAL(4, 46, 8),
QT_MOC_LITERAL(5, 55, 22),
QT_MOC_LITERAL(6, 78, 5),
QT_MOC_LITERAL(7, 84, 13),
QT_MOC_LITERAL(8, 98, 12),
QT_MOC_LITERAL(9, 111, 15),
QT_MOC_LITERAL(10, 127, 9),
QT_MOC_LITERAL(11, 137, 14),
QT_MOC_LITERAL(12, 152, 12),
QT_MOC_LITERAL(13, 165, 4),
QT_MOC_LITERAL(14, 170, 4),
QT_MOC_LITERAL(15, 175, 11),
QT_MOC_LITERAL(16, 187, 6),
QT_MOC_LITERAL(17, 194, 9),
QT_MOC_LITERAL(18, 204, 13)
    },
    "QXmppIceComponent\0connected\0\0"
    "datagramReceived\0datagram\0"
    "localCandidatesChanged\0close\0connectToHost\0"
    "sendDatagram\0checkCandidates\0checkStun\0"
    "handleDatagram\0QHostAddress\0host\0port\0"
    "QUdpSocket*\0socket\0readyRead\0turnConnected\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QXmppIceComponent[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      12,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   74,    2, 0x06,
       3,    1,   75,    2, 0x06,
       5,    0,   78,    2, 0x06,

 // slots: name, argc, parameters, tag, flags
       6,    0,   79,    2, 0x0a,
       7,    0,   80,    2, 0x0a,
       8,    1,   81,    2, 0x0a,
       9,    0,   84,    2, 0x08,
      10,    0,   85,    2, 0x08,
      11,    4,   86,    2, 0x08,
      11,    3,   95,    2, 0x28,
      17,    0,  102,    2, 0x08,
      18,    0,  103,    2, 0x08,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::QByteArray,    4,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::LongLong, QMetaType::QByteArray,    4,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QByteArray, 0x80000000 | 12, QMetaType::UShort, 0x80000000 | 15,    4,   13,   14,   16,
    QMetaType::Void, QMetaType::QByteArray, 0x80000000 | 12, QMetaType::UShort,    4,   13,   14,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void QXmppIceComponent::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QXmppIceComponent *_t = static_cast<QXmppIceComponent *>(_o);
        switch (_id) {
        case 0: _t->connected(); break;
        case 1: _t->datagramReceived((*reinterpret_cast< const QByteArray(*)>(_a[1]))); break;
        case 2: _t->localCandidatesChanged(); break;
        case 3: _t->close(); break;
        case 4: _t->connectToHost(); break;
        case 5: { qint64 _r = _t->sendDatagram((*reinterpret_cast< const QByteArray(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< qint64*>(_a[0]) = _r; }  break;
        case 6: _t->checkCandidates(); break;
        case 7: _t->checkStun(); break;
        case 8: _t->handleDatagram((*reinterpret_cast< const QByteArray(*)>(_a[1])),(*reinterpret_cast< const QHostAddress(*)>(_a[2])),(*reinterpret_cast< quint16(*)>(_a[3])),(*reinterpret_cast< QUdpSocket*(*)>(_a[4]))); break;
        case 9: _t->handleDatagram((*reinterpret_cast< const QByteArray(*)>(_a[1])),(*reinterpret_cast< const QHostAddress(*)>(_a[2])),(*reinterpret_cast< quint16(*)>(_a[3]))); break;
        case 10: _t->readyRead(); break;
        case 11: _t->turnConnected(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (QXmppIceComponent::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QXmppIceComponent::connected)) {
                *result = 0;
            }
        }
        {
            typedef void (QXmppIceComponent::*_t)(const QByteArray & );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QXmppIceComponent::datagramReceived)) {
                *result = 1;
            }
        }
        {
            typedef void (QXmppIceComponent::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QXmppIceComponent::localCandidatesChanged)) {
                *result = 2;
            }
        }
    }
}

const QMetaObject QXmppIceComponent::staticMetaObject = {
    { &QXmppLoggable::staticMetaObject, qt_meta_stringdata_QXmppIceComponent.data,
      qt_meta_data_QXmppIceComponent,  qt_static_metacall, 0, 0}
};


const QMetaObject *QXmppIceComponent::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QXmppIceComponent::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QXmppIceComponent.stringdata))
        return static_cast<void*>(const_cast< QXmppIceComponent*>(this));
    return QXmppLoggable::qt_metacast(_clname);
}

int QXmppIceComponent::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QXmppLoggable::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 12)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 12;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 12)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 12;
    }
    return _id;
}

// SIGNAL 0
void QXmppIceComponent::connected()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void QXmppIceComponent::datagramReceived(const QByteArray & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void QXmppIceComponent::localCandidatesChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}
struct qt_meta_stringdata_QXmppIceConnection_t {
    QByteArrayData data[9];
    char stringdata[113];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    offsetof(qt_meta_stringdata_QXmppIceConnection_t, stringdata) + ofs \
        - idx * sizeof(QByteArrayData) \
    )
static const qt_meta_stringdata_QXmppIceConnection_t qt_meta_stringdata_QXmppIceConnection = {
    {
QT_MOC_LITERAL(0, 0, 18),
QT_MOC_LITERAL(1, 19, 9),
QT_MOC_LITERAL(2, 29, 0),
QT_MOC_LITERAL(3, 30, 12),
QT_MOC_LITERAL(4, 43, 22),
QT_MOC_LITERAL(5, 66, 5),
QT_MOC_LITERAL(6, 72, 13),
QT_MOC_LITERAL(7, 86, 13),
QT_MOC_LITERAL(8, 100, 11)
    },
    "QXmppIceConnection\0connected\0\0"
    "disconnected\0localCandidatesChanged\0"
    "close\0connectToHost\0slotConnected\0"
    "slotTimeout\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QXmppIceConnection[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   49,    2, 0x06,
       3,    0,   50,    2, 0x06,
       4,    0,   51,    2, 0x06,

 // slots: name, argc, parameters, tag, flags
       5,    0,   52,    2, 0x0a,
       6,    0,   53,    2, 0x0a,
       7,    0,   54,    2, 0x08,
       8,    0,   55,    2, 0x08,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void QXmppIceConnection::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QXmppIceConnection *_t = static_cast<QXmppIceConnection *>(_o);
        switch (_id) {
        case 0: _t->connected(); break;
        case 1: _t->disconnected(); break;
        case 2: _t->localCandidatesChanged(); break;
        case 3: _t->close(); break;
        case 4: _t->connectToHost(); break;
        case 5: _t->slotConnected(); break;
        case 6: _t->slotTimeout(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (QXmppIceConnection::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QXmppIceConnection::connected)) {
                *result = 0;
            }
        }
        {
            typedef void (QXmppIceConnection::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QXmppIceConnection::disconnected)) {
                *result = 1;
            }
        }
        {
            typedef void (QXmppIceConnection::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QXmppIceConnection::localCandidatesChanged)) {
                *result = 2;
            }
        }
    }
    Q_UNUSED(_a);
}

const QMetaObject QXmppIceConnection::staticMetaObject = {
    { &QXmppLoggable::staticMetaObject, qt_meta_stringdata_QXmppIceConnection.data,
      qt_meta_data_QXmppIceConnection,  qt_static_metacall, 0, 0}
};


const QMetaObject *QXmppIceConnection::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QXmppIceConnection::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QXmppIceConnection.stringdata))
        return static_cast<void*>(const_cast< QXmppIceConnection*>(this));
    return QXmppLoggable::qt_metacast(_clname);
}

int QXmppIceConnection::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QXmppLoggable::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 7;
    }
    return _id;
}

// SIGNAL 0
void QXmppIceConnection::connected()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void QXmppIceConnection::disconnected()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void QXmppIceConnection::localCandidatesChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}
QT_END_MOC_NAMESPACE
