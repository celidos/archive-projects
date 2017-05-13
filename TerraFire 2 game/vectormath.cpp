#include "vectormath.h"

const rvector GetNormal3v3f(const float *a, const float *b, const float *c)
{
    rvector A, B, C;
    A.form(a[0], a[1], a[2]);
    B.form(b[0], b[1], b[2]);
    C.form(c[0], c[1], c[2]);
    rvector ans;
    ans = (A - C) * (B - C);
    ans.NormalizeTo(1.0f);
    return ans;
}

void To360degrees(float & a)
{
    if (a > 360.0f)
        a -= 360.0f;
    else if (a < 0)
        a += 360;
}

float Distance(rvector a, rvector b)
{
    return sqrt(qw(b[0] - a[0]) + qw(b[1] - a[1]) + qw(b[2] - a[2]));
}

float AngleBetweenVectors (rvector a, rvector b)
{
    return acos(a.ScalarP(b) / (a.abs() * b.abs()) );
}

float RandomD(float limits)
{
    int t = rand() % 32000 - 16000;
    return limits * t * 0.0000625; // то же, что / 16000;
}
