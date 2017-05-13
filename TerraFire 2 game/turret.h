#ifndef TURRET_H_INCLUDED
#define TURRET_H_INCLUDED

#include <GL/gl.h>
#include <GL/glut.h>
#include <math.h>

#include "bullet.h"
#include "additionalgraphics.h"

class Turret
{
public:
    rvector pos;
    int health;
    Turret(){};
    Turret(rvector &StartPosition) {pos = StartPosition; health = 100;};
    ~Turret(){};

    void Draw(rvector &Droid);
    Bullet Shoot(rvector &Droid);
};

const float basesize = 3;
const float Rsize    = 2.5;

#endif // TURRET_H_INCLUDED
