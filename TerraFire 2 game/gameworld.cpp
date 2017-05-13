#include "gameworld.h"

GLfloat  WHITELight[] = { 0.5f, 0.5f,  0.5f, 1.0f };

const int maxlifetime = 20;
const int maxstage    = 25;
extern bool dbAutoBullets;

Explosion::Explosion(rvector &Position, int type)
{
    pos = Position;
    stage = 0;
    this-> type = type;
}

bool Explosion::IncStage()
{
    ++stage;
    if (stage > maxstage)
    {
        stage = 0;
        return true;
    }
    return false;
}

void Explosion::Draw()
{
     const float R = (type == 0 ? 4 : 100);//4;
     glPushMatrix();
        glPushAttrib(GL_LIGHTING_BIT);
            //glLightfv(GL_LIGHT0, GL_DIFFUSE, WHITELight);
            //glLightModelfv(GL_LIGHT_MODEL_AMBIENT, WHITELight);
            glDisable(GL_LIGHTING);
            glTranslatef(pos[0], pos[1], pos[2]);
            glColor3ub(255, 255 - stage*10, 210 - stage*7);
            //glColor3ub(255, 255, 255);
            if (stage < 5)
                glutSolidSphere((R * (5 - stage) / 25), 32, 32);
            else
                glutSolidSphere(R - R / sqrt(sqrt (3 * stage)) , 32, 32);

        glPopAttrib();
    glPopMatrix();
}

void Particular::Draw()
{
    glPushMatrix();
        glPushAttrib(GL_LIGHTING_BIT);
            //glLightfv(GL_LIGHT0, GL_DIFFUSE, WHITELight);
            //glLightModelfv(GL_LIGHT_MODEL_AMBIENT, WHITELight);
            glDisable(GL_LIGHTING);
            glTranslatef(pos[0], pos[1], pos[2]);
            glColor3ub(255, 255 - lifetime * 255 / maxlifetime, 0);
            glutSolidSphere(0.2, 6, 6);

        glPopAttrib();
    glPopMatrix();
}

GameWorld::GameWorld(vector <Wall> &SomeWalls)
{
    int n = SomeWalls.size();
    Wall emptywall;
    for (int i = 0; i < n; ++i)
    {
        walls.push_back(SomeWalls[i]);
    }
}

GameWorld::~GameWorld()
{
    walls.clear();
    bullets.clear();
    explosions.clear();
    droidparts.clear();
}

void GameWorld::CreateBullet(rvector Position, rvector Speed, BulletType BType)
{
    Bullet b (Position, Speed, BType);
    bullets.push_back(b);
}

void GameWorld::Draw()
{
    int n = walls.size();
    for (int j = 0; j < n; ++j)
    {
        //printf("vcount = %i", walls[j].vcount);
        walls[j].Draw();
    }
    list <Bullet>::iterator i;
    list <Explosion>::iterator e;
    list <Particular>::iterator p;

    for (i = bullets.begin(); i != bullets.end(); ++i)
        (*i).Draw();

    for (e = explosions.begin(); e != explosions.end(); ++e)
        (*e).Draw();

    for (p = droidparts.begin(); p != droidparts.end(); ++p)
        (*p).Draw();

}

void GameWorld::ScanWallsFromFloat12Array(int n, float a[][12])
{
    Wall emptywall;

    for (int i = 0; i < n; ++i)
    {
        rvector A(a[i][0], a[i][1], a[i][2]),
                B(a[i][3], a[i][4], a[i][5]),
                C(a[i][6], a[i][7], a[i][8]),
                col(a[i][9], a[i][10], a[i][11]);

        Wall t(A, B, C, col);
        walls.push_back(t);         // Тонкое место! Для него пришлось переопределять конструктор копирования для Wall,
                                    //  иначе возникала ошибка из-за указателей, указывающих на одну и ту же область памяти
    }

    /*bsp.Build(walls);
    printf("Let's look what we get:");
    for (int i = 0; i < 1024; ++i)
    {
        printf("%i ", bsp.Nodes[i]);
    }
    printf(" | \n");*/

}

void GameWorld::Refresh_mechanic(rvector &DroidPos)
{
        list <Bullet>::iterator i;
        int n = walls.size();
        for (i = bullets.begin(); i != bullets.end(); )
        {
            (*i).lastpos = (*i).pos;
            (*i).pos     = (*i).pos + (*i).v;
            rvector vline[] = {(*i).lastpos, (*i).pos}; // 2 точки, задающие отрезок (нач. полож.; конечн. полож.)
            rvector PosOfIntersection;                  // Сюда запишется будущая точка пересечения (если таковая есть)
            bool flag = false; // Для выхода из двойного цикла
            // Пока перебираются все полигоны, если один уже был пересечен, то мы обрабатываем
            //  это событие и выходим из цикла - для этого и нужен флаг
            for (int j = 0; j < n; ++j)
            {
                if (IntersectedPolygon (walls[j].v, vline, walls[j].vcount, PosOfIntersection))
                {
                    if (dbAutoBullets)
                        printf("Bullet Intersection!\n");
                    Explosion newexp(PosOfIntersection, ((*i).btype == btLevel1 ? 0 : 1)); // Создаем взрыв
                    explosions.push_back(newexp);
                    bullets.erase(i++);

                    flag = true;
                    break;
                }
            }

            if (flag)
                continue;

            if ((DroidPos - (*i).pos).Manhattan() > 1e+3)   // Если пуля улетела слишком далеко, то её лучше убрать
                bullets.erase(i++);
            else                                            // Пуля летит дальше
                ++i;
        }

        list <Explosion>::iterator e;
        for (e = explosions.begin(); e != explosions.end(); )
        {
            if ((*e).IncStage())
            {
                explosions.erase(e++);
            }
            else
                ++e;
        }

        list <Particular>::iterator p;
        for (p = droidparts.begin(); p != droidparts.end(); )
        {
            (*p).pos = (*p).pos + (*p).v;
            ++((*p).lifetime);
            if ( (*p).lifetime > maxlifetime )
                droidparts.erase(p++);
            else
                ++p;
        }
}
