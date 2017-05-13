#include "additionalgraphics.h"

void DrawCube(float size)
{
    glBegin(GL_QUADS);
        glVertex3f(+size,+size,+size);
        glVertex3f(-size,+size,+size);
        glVertex3f(-size,-size,+size);
        glVertex3f(+size,-size,+size);

        glVertex3f(+size,+size,-size);
        glVertex3f(-size,+size,-size);
        glVertex3f(-size,-size,-size);
        glVertex3f(+size,-size,-size);

        glVertex3f(+size,+size,+size);
        glVertex3f(-size,+size,+size);
        glVertex3f(-size,+size,-size);
        glVertex3f(+size,+size,-size);

        glVertex3f(+size,-size,+size);
        glVertex3f(-size,-size,+size);
        glVertex3f(-size,-size,-size);
        glVertex3f(+size,-size,-size);

        glVertex3f(+size,+size,+size);
        glVertex3f(+size,-size,+size);
        glVertex3f(+size,-size,-size);
        glVertex3f(+size,+size,-size);

        glVertex3f(-size,+size,+size);
        glVertex3f(-size,-size,+size);
        glVertex3f(-size,-size,-size);
        glVertex3f(-size,+size,-size);
    glEnd();
}

void DrawWorldAxises(float Size)
{
    glBegin(GL_LINES);
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex3f(-1.0f, 0.0f, 0.0f);
        glVertex3f(Size, 0.0f, 0.0f);

        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex3f(0.0f, -1.0f, 0.0f);
        glVertex3f(0.0f, Size, 0.0f);

        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex3f(0.0f, 0.0f, -1.0f);
        glVertex3f(0.0f, 0.0f, Size);
    glEnd();
}

void DrawChessPlate()
{
    glBegin(GL_QUADS);
        glColor3f(0.4f, 0.0f, 0.9f);
        glVertex3f(-200.0f, -10.0f, -200.0f);
        glVertex3f(-200.0f, -10.0f,  200.0f);
        glVertex3f( 200.0f, -10.0f,  200.0f);
        glVertex3f( 200.0f, -10.0f, -200.0f);


        for (int i = -15; i < 16; ++i)
        {
            for (int j = -15; j < 16; ++j)
            {
                if ((i + j) & 1)
                    glColor3f(0.1f, 0.05f, 0.0f);
                else
                    glColor3f(1.0f, 0.95f, 0.7f);
                glVertex3f(i*10.0f, -9.8f, j*10.0f);
                glVertex3f((i+1)*10.0f, -9.8f, j*10.0f);
                glVertex3f((i+1)*10.0f, -9.8f, (j+1)*10.0f);
                glVertex3f(i*10.0f, -9.8f, (j+1)*10.0f);
            }
        }
    glEnd();
}

void DrawSomeTeapots()
{
    glPushMatrix();
        glTranslatef(-100, 0, -50);

        GLUquadricObj* m_qObj = gluNewQuadric();
        glColor3f(1.0f, 0.5f, 0.9f);
        gluSphere(m_qObj, 5, 15, 15);

        glTranslatef(200, 0, 170);
        glColor3f(0.2f, 0.4f, 0.9f);

        gluSphere(m_qObj, 7, 15, 15);

        glTranslatef(0, -3, -170);
        glColor3f(0.88f, 0.62f, 1.0f);
        glutSolidTeapot(10);
        glTranslatef(0, 0, -100);
        glColor3f(1.0f, 1.0f, 0.0f);
        glutSolidTeapot(5);
    glPopMatrix();
}
