#-------------------------------------------------
#
# Project created by QtCreator 2014-09-30T14:54:00
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = fractal
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    fractalpainter.cpp

HEADERS  += mainwindow.h \
    fractalpainter.h \
    complex.hpp \
    timerwork.h

FORMS    += mainwindow.ui

CONFIG += c++11
