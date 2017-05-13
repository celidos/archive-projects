#ifndef BULLET_H_INCLUDED
#define BULLET_H_INCLUDED

#include <GL/gl.h>
#include <GL/glut.h>

#include "vectormath.h"

enum BulletType {btLevel1 = 1, btLevel2 = 2, btLevel3 = 3};
class Bullet
{
public:
    rvector pos;
    rvector lastpos;
    rvector v;
    BulletType btype;

    Bullet(){};
    Bullet(rvector &Position, rvector &Speed, BulletType BType) {SetParams(Position, Speed, BType);};
    ~Bullet(){};

    void SetParams(rvector Position, rvector &Speed, BulletType BType);
    void Draw();
};

#endif // BULLET_H_INCLUDED
