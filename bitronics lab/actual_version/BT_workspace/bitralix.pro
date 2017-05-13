QT += widgets serialport printsupport

TARGET = bitrallix
TEMPLATE = app
CONFIG += c++11

RC_ICONS = images\favicon.ico

SOURCES += \
    main.cpp \
    mainwindow.cpp \
    settingsdialog.cpp \
    qcustomplot.cpp \
    fourier.cpp \
    logger.cpp \
    fouriertrigger.cpp \
    parcer.cpp \
    bank.cpp \
    plotfourier.cpp \
    plotdiff.cpp \
    datakeeper.cpp \
    plotemg.cpp \
    plot.cpp \
    fft.cpp \
    serialportmaster.cpp

HEADERS += \
    mainwindow.h \
    settingsdialog.h \
    qcustomplot.h \
    fourier.h \
    logger.h \
    fouriertrigger.h \
    parcer.h \
    bank.h \
    plotfourier.h \
    plotdiff.h \
    enumeration.h \
    datakeeper.h \
    plotemg.h \
    plot.h \
    fft.h \
    about.h \
    serialportmaster.h

FORMS += \
    mainwindow.ui \
    settingsdialog.ui

RESOURCES += \
    trminal1.qrc

DISTFILES +=
