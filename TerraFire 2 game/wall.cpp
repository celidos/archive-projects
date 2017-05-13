#include "wall.h"

Wall::Wall(rvector A, rvector B, rvector C, rvector Color)
{
    vcount = 3;
    v = new rvector [3];
    v[0] = A;
    v[1] = B;
    v[2] = C;
    color = Color;
}

Wall::Wall(rvector A, rvector B, rvector C, rvector D, rvector Color)
{
    vcount = 4;
    v = new rvector [4];
    v[0] = A;
    v[1] = B;
    v[2] = C;
    v[3] = D;
    color = Color;
}

Wall::Wall(const Wall &w)
{
    vcount = w.vcount;
    v = new rvector [vcount];

    color = w.color;

    for (int i = 0; i < vcount; ++i)
    {

        v[i] = w.v[i];
//        printf("ok! vcount = %i\n", vcount);
    }
}

Wall& Wall::operator= (Wall w)
{
    vcount = w.vcount;
    v = new rvector [vcount];

    color = w.color;

    for (int i = 0; i < vcount; ++i)
    {

        v[i] = w.v[i];
        //printf("ok! vcount = %i\n", vcount);
    }
}

void Wall::Draw()
{
    glColor3fv(color.data);
    if (vcount == 3)
        glBegin(GL_TRIANGLES);
    else if (vcount == 4)
        glBegin(GL_QUADS);

    for (int k = 0; k < vcount; ++k)
        glVertex3fv(v[k].data);

    glEnd();
}
