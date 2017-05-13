#include <QCoreApplication>
#include <iostream>

#include "sofa-pr.h"

int main()
{ 
    Polygon p;
    p.v.push_back(v2d(-1, 2));
    p.v.push_back(v2d(1, 1));
    p.v.push_back(v2d(3, -1));
    p.v.push_back(v2d(1, -2));
    p.v.push_back(v2d(-2, -1));

    cout << p.getS() << endl;
}
