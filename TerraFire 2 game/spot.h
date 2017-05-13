#ifndef SPOT_H_INCLUDED
#define SPOT_H_INCLUDED

#include <GL/gl.h>
#include <GL/glut.h>

GLfloat  spotDir[3] = { 0.0f, 0.0f, -1.0f };

class FlySpotLight
{
public:
    float lightPos[3];
    float angle;

    FlySpotLight(){};
    FlySpotLight(float X, float Y, float Z, float Angle = 0)
    {
        lightPos[0] = X;
        lightPos[1] = Y;
        lightPos[2] = Z;
        angle = Angle;
    }

    void Draw()
    {
    glPushMatrix();
        glTranslatef(lightPos[0], lightPos[1], lightPos[2]);
        glRotatef(angle, 0.0f, 1.0f, 0.0f);

        glLightfv(GL_LIGHT1, GL_POSITION, lightPos);
        glLightfv(GL_LIGHT1, GL_SPOT_DIRECTION, spotDir);

        glColor3ub(255,0,0);

        glutSolidCone(1.0f, 2.0f, 8, 8);

        // Draw a smaller displaced sphere to denote the light bulb
        // Save the lighting state variables
        glPushAttrib(GL_LIGHTING_BIT);

            // Turn off lighting and specify a bright yellow sphere
            glDisable(GL_LIGHTING);
            glColor3ub(255,255,0);
            glutSolidSphere(0.5f, 8, 8);

        // Restore lighting state variables
        glPopAttrib();

    // Restore coordinate transformations
    glPopMatrix();
    }
};

#endif // SPOT_H_INCLUDED
