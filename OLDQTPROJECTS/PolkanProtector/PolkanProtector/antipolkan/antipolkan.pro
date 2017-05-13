#-------------------------------------------------
#
# Project created by QtCreator 2014-11-25T23:39:39
#
#-------------------------------------------------

QT       += core gui
QT       += serialport
QT       += network
QT       += xml

INCLUDEPATH += /usr/local/include/qxmpp
INCLUDEPATH += /usr/local/lib
INCLUDEPATH += $$QXMPP_INCLUDEPATH
LIBS += $$QXMPP_LIBS
LIBS += -L/usr/local/lib -lqxmpp

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

include(qextserialport-1.2rc/src/qextserialport.pri)

TARGET = antipolkan
TEMPLATE = app

QMAKE_CXXFLAGS += -std=c++0x
SOURCES += main.cpp\
    alarmdialog.cpp \
    port.cpp \
    polkanmaster.cpp \
    xmppclient.cpp

FORMS    += \
    alarmdialog.ui \
    window_polkan.ui

SUBDIRS += \
    qxmpp-master/src/src.pro

HEADERS += \
    alarmdialog.h \
    polkanmaster.h \
    port.h \
    xmppclient.h
