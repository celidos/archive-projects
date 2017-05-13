#ifndef VECTORMATH_H_INCLUDED
#define VECTORMATH_H_INCLUDED

#include <math.h>
#include <stdlib.h>

const float PI_DIV_360  = 0.017453292519943295;
const float _360_DIV_PI = 114.591559026;

inline float qw(float x)
{
    return x * x;
}

class rvector
{
public:
    float data[3];

    rvector ()
    {
        data[0] = data[1] = data[2] = 0;
    }
    rvector (float X, float Y, float Z)
    {
        data[0] = X;
        data[1] = Y;
        data[2] = Z;
    }
    void form(float X, float Y, float Z)
    {
        data[0] = X;
        data[1] = Y;
        data[2] = Z;
    }
    float abs()
    {
        return sqrt(qw(data[0]) + qw(data[1]) + qw(data[2]));
    }
    float Manhattan()
    {
        return fabs(data[0]) + fabs(data[1]) + fabs(data[2]);
    }
    float len2()
    {
        return qw(data[0]) + qw(data[1]) + qw(data[2]);
    }

    rvector NormalizeTo(float NewLength)
    {
        float k = abs();
        if (k > 1e-10)
            k = NewLength / k;

        data[0] *= k;
        data[1] *= k;
        data[2] *= k;
        return (*this);
    }

    float& operator [] (unsigned int index)
    {
        return data[index];
    }

    rvector operator + (rvector& b)
    {
        rvector ans;
        ans.form(data[0] + b[0], data[1] + b[1], data[2] + b[2]);
        return ans;
    }

    rvector operator - (const rvector& b) const
    {
        rvector ans (this->data[0] - b.data[0], this->data[1] - b.data[1], this->data[2] - b.data[2]);
        return ans;
    }

    rvector operator * (rvector b)
    {
        rvector ans(data[1]*b[2] - data[2]*b[1],
                    data[2]*b[0] - data[0]*b[2],
                    data[0]*b[1] - data[1]*b[0]);
        return ans;
    }

    rvector operator * (float a)
    {
        rvector ans;
        ans.form(data[0] * a,
                 data[1] * a,
                 data[2] * a);
        return ans;
    }

    void operator += (rvector& b)
    {
        data[0] += b[0];
        data[1] += b[1];
        data[2] += b[2];
    }

    void operator -= (rvector& b)
    {
        data[0] -= b[0];
        data[1] -= b[1];
        data[2] -= b[2];
    }

    float ScalarP (rvector b)
    {
        return (data[0] * b[0] + data[1] * b[1] + data[2] * b[2]);
    }
};

const rvector GetNormal3v3f(const float *a, const float *b, const float *c);
void To360degrees(float & a);
float Distance(rvector a, rvector b);
float AngleBetweenVectors (rvector a, rvector b);
float RandomD(float limits);

#endif // VECTORMATH_H_INCLUDED
