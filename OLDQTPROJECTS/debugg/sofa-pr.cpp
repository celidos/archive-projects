#include "sofa-pr.h"

Polygon::Polygon()
{

}

Polygon::~Polygon()
{

}

FLOAT Polygon::getS()
{
    FLOAT ans = 0.0;

    for (list <v2d>::iterator i = v.begin(); i != v.end(); i++)
    {
        if (i != v.end())
        {
            v2d a = *i;
            i++;
            v2d b = *i;
            i--;
            ans += a.pscalar(b);
        }
    }
    ans += v.back().pscalar(v.front());
    ans = fabs(ans) / 2.0;
    return ans;
}


