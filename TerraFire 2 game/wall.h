#ifndef WALL_H_INCLUDED
#define WALL_H_INCLUDED

#include <GL/gl.h>
#include <GL/glut.h>
#include <stdio.h>

#include "vectormath.h"

class Wall
{
public:
    int vcount;
    rvector *v = 0;
    rvector color;


    Wall(){};
    Wall(const Wall &w);
    Wall(rvector A, rvector B, rvector C, rvector Color);
    Wall(rvector A, rvector B, rvector C, rvector D, rvector Color);
    ~Wall(){delete [] v;};

    Wall& operator= (Wall w);

    void Draw();
};

#endif // WALL_H_INCLUDED
