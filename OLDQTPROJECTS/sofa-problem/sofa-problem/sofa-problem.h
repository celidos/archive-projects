#ifndef SOFAPROBLEM_H
#define SOFAPROBLEM_H

#include "mathematics.h"
#include <list>

using namespace std;

class Polygon
{
public:
    list <v2d> v;           // Вершины

    Polygon ();
    ~Polygon ();

    FLOAT getS();           // Получить площадь
};

#endif // SOFAPROBLEM_H
