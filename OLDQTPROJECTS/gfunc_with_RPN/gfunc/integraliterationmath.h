#ifndef INTEGRAL_H
#define INTEGRAL_H

#include <iostream>

using namespace std;

typedef float (*ffp2f)(float, float);
typedef float (*ffp1f)(float);

float Integral(ffp2f F, float a, float b, float x, float eps1);
float SolveIterations(ffp1f F, float a, float b, float startpoint, float eps2);


#endif // INTEGRAL_H
