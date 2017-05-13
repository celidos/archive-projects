#-------------------------------------------------
#
# Project created by QtCreator 2015-03-04T09:14:06
#
#-------------------------------------------------

QT       += core gui
QT       += serialport
QT       += network
QT       += xml

INCLUDEPATH += /usr/local/lib

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

include(qextserialport-1.2rc/src/qextserialport.pri)

TARGET = lasertrans
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    port.cpp

HEADERS  += mainwindow.h \
    port.h

FORMS    += mainwindow.ui

SUBDIRS += \
    qextserialport-1.2rc/qextserialport.pro
