#-------------------------------------------------
#
# Project created by QtCreator 2014-11-25T23:39:39
#
#-------------------------------------------------

QT       += core gui
QT       += serialport

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

include(qextserialport-1.2rc/src/qextserialport.pri)

TARGET = antipolkan
TEMPLATE = app

QMAKE_CXXFLAGS += -std=c++0x
SOURCES += main.cpp\
    alarmdialog.cpp \
    port.cpp \
    polkanmaster.cpp

HEADERS  += \
    alarmdialog.h \
    port.h \
    polkanmaster.h

FORMS    += \
    alarmdialog.ui \
    window_polkan.ui
