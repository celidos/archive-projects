#include "turret.h"

void Turret::Draw(rvector &Droid)
{
    glPushMatrix();
        glTranslatef(pos[0], pos[1], pos[2]);
        glColor3ub(180, 177, 183);
        DrawCube(basesize);
        glTranslatef(0, basesize, 0);
        glColor3ub(40, 25, 240);
        glutSolidSphere(Rsize, 8, 8);

        rvector turn(0, basesize, 0), e(0.0, 0.0, 1.0), ans;
        turn = Droid - pos - turn;
        ans = turn * e;
        glRotatef(acos(e.ScalarP(turn) / turn.abs()) * _360_DIV_PI * 0.5, -ans[0], -ans[1], -ans[2]);

        glColor3ub(255, 255, 23);
        glutSolidCone(0.5f, 8.0f, 8, 8);
    glPopMatrix();
}

Bullet Turret::Shoot(rvector &Droid)
{
    rvector x(0, basesize, 0);
    rvector e(0.0, 0.0, 1.0);
    rvector turn = Droid - pos - x;
    turn.NormalizeTo(3);
    Bullet newb;
    newb.pos = x + pos + turn;
    newb.v = turn;
    newb.btype = btLevel1;
    return newb;
}
