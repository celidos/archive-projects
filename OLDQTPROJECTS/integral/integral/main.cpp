#include <iostream>
#include <cstdlib>
#include <cmath>

using namespace std;

typedef float (*ffp2f)(float, float);
typedef float (*ffp1f)(float);

float function(float x, float y)
{
    return y*y;
}

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

    cout << "tempans = "<< tempans << endl;
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
        cout << "diff ( " << tempans<< "; " << ans << "); addans = " << addans << "\n";
        if (tempans < 0.26)
            cout << "delta = " << delta <<"; steps = " << steps <<"; g/s = " << delta/steps << "; steps =  " << steps << endl ;
    }
    while (fabs(tempans - ans) > eps1);
    return tempans;
}

int main()
{
    cout.precision(10);
    cout << "Counting... \n" << Integral(function, 0, 1, 0, .00001) << " = our ans" << endl;
    return 0;
}
