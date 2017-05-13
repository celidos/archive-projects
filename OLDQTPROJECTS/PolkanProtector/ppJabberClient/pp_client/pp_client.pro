#-------------------------------------------------
#
# Project created by QtCreator 2015-01-30T15:46:04
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

TARGET = pp_client
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    form.cpp

HEADERS  += mainwindow.h \
    form.h

FORMS    += mainwindow.ui \
    form.ui
