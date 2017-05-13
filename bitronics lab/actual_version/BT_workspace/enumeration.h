#ifndef ENUMERATION_H
#define ENUMERATION_H

#define MAX_RANGE 20.               // Максимально возможная развёртка сигнала
#define MAX_Y_ARR 4                 // Количество входных каналов (А0, ...)
#define POINTS_FOR_FOURIER 1024      // Сколько точек мы будем брать для фурье

typedef double DATA;

enum Channel {A0=0, A1=1, A2=2, A3=3};

enum TriggerId {Trigger0, Trigger1, Trigger2, Trigger3};

enum SignalType {EMG, EEG};

#endif // ENUMERATION_H
