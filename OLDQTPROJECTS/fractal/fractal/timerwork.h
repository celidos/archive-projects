#ifndef TIMERWORK_H
#define TIMERWORK_H

#include <ctime>
#include <time.h>

class Timer
{
private:
    clock_t starttime;
    clock_t time;
public:
    void Start()
    {
        starttime = clock();
    }
    unsigned int GetTimeFromStart()
    {
        return clock() - starttime;
    }
    float GetTimeFromStart_inms()
    {
        return (clock() - starttime)*1.0/CLOCKS_PER_SEC;
    }
};


#endif // TIMERWORK_H
