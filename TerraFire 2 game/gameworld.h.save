#ifndef GAMEWORLD_H_INCLUDED
#define GAMEWORLD_H_INCLUDED

#include <GL/gl.h>
#include <GL/glut.h>
#include <list>
#include <vector>
#include <stdio.h>
#include <time.h>

#include "physics.h"
#include "wall.h"
#include "turret.h"

using namespace std;

static rvector whitecolor(1.0f, 1.0f, 1.0f);

class Explosion
{
private:
    int stage;
public:
    rvector pos;
    float R;
    int type;

    Explosion(rvector &Position, int type);
    ~Explosion(){};

    bool IncStage();
    void Draw();
};

class Particular
{
public:
    rvector pos;
    rvector v;
    int lifetime;

    Particular(rvector &StartPos, rvector &Speed) {lifetime = 0; pos = StartPos; v = Speed;};
    ~Particular(){};

    void Draw();
};

class GameWorld
{
public:
    vector <Wall> walls;

    //BSP bsp;

    list <Bullet> bullets;
    list <Explosion> explosions;
    list <Particular> droidparts;

    GameWorld(){};
    GameWorld(vector <Wall> &SomeWalls);
    ~GameWorld();

    void ScanWallsFromFloat12Array(int n, float a[][12]);

    void CreateBullet(rvector Position, rvector Speed, BulletType BType);
    void Refresh_mechanic(rvector &DroidPos);
    void Draw();
};

#endif // GAMEWORLD_H_INCLUDED
