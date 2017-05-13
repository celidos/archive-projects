#include "bullet.h"

void Bullet::SetParams(rvector Position, rvector &Speed, BulletType BType)
{
    pos     = Position;
    lastpos = Position;
    v       = Speed;
    btype   = BType;
}

void Bullet::Draw()
{
    glPushMatrix();
        glPushAttrib(GL_LIGHTING_BIT);
            glDisable(GL_LIGHTING);
            switch (btype)
            {
                case 1:
                    glColor3f(0.2f, 1.0f, 0.05f); break;
                case 2:
                    glColor3f(1.0f, 1.0f, 0.0f); break;
                case 3:
                    glColor3f(1.0f, 0.2f, 0.0f); break;
            }
            glTranslatef(pos[0], pos[1], pos[2]);
            glutSolidSphere(btype*0.2, 6, 6);
        glPopAttrib();
    glPopMatrix();
}
