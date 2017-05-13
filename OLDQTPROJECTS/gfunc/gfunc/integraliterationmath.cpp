#include "integraliterationmath.h"
#include <algorithm>
#include <cstdlib>
#include <cmath>

float Integral(ffp2f F, float a, float b, float x, float eps1)
{
    if (b < a) swap(a, b);

    float ans = 0, tempans = 0, delta = b - a;
    long long int steps = 2;
    float lastf, newf;

    tempans = (F(x, a) + F(x, b)) * 0.5;
    for (int i = 1; i < steps; ++i)
    {
        tempans +=  F(x, a + delta * i / steps);
    }
    tempans *= delta / steps;
    do
    {
        steps *= 2;
        ans = tempans;
        tempans *= 0.5;
        float addans = 0;
        for (int i = 1; i < steps; i += 2)
        {
            addans += F(x, a + delta * i / steps);
        }
        addans = addans * delta / steps;
        tempans += addans;
    }
    while (fabs(tempans - ans) > eps1);
    return tempans;
}

float SolveIterations(ffp1f F, float a, float b, float startpoint, float eps2)
{
    float dt1 = startpoint, dt1r = startpoint;
    int count = 0;
    do
    {
        ++count;
        dt1 = dt1r;
        dt1r = F(dt1) + dt1;
        cout << dt1r - dt1 << endl;
    }
    while (fabs(dt1r - dt1) > eps2 * 0.1);
    cout << "Число итераций - " << count << endl;
    return dt1r;
}
