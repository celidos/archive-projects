#include "droid.h"

extern bool dbAutoIntersect;
float brakespeed      = 0.02;
float max_v           = 2.0f;
float max_v2          = max_v * max_v;
float move_speed      = 0.08f;
float BulletSpeed     = 3;

extern bool dbAutoBullets;

void m3t (float * a, const float * b) // Копирует один массив float[3]  в другой массив float[3]
{
    a[0] = b[0];
    a[1] = b[1];
    a[2] = b[2];
}

Droid::Droid(rvector rvPosition, rvector rvTurn, GameWorld *World)
{
    pos = rvPosition;
    turn = rvTurn;
    v.form(0.0f, 0.0f, 0.0f);
    rot_angle = 0.0f;
    gworld = World;
    RefreshLightmap();
}

void Droid::Normalize_v()
{
    float d = qw(v[0]) + qw(v[1]) + qw(v[2]);
    if (d > max_v2)
    {
        float t = max_v / sqrt(d);
        v[0] *= t;
        v[1] *= t;
        v[2] *= t;
    }
}

void Droid::CountRealVertexes()
{
    float a = (H_angle - turn[0]) * PI_DIV_360, b = - turn[1] * PI_DIV_360;
    float rotmatrix[3][3] =
    {
        {cos(b), sin(a)*sin(b), sin(b)*cos(a)},
        {0, cos(a), -sin(a)},
        {-sin(b), sin(a)*cos(b), cos(a)*cos(b)}
    };
    for (int i = 0; i < 10; ++i)
    {
        realv[i][0] = m[i][0] * rotmatrix[0][0] + m[i][1] * rotmatrix[0][1] + m[i][2] * rotmatrix[0][2] - pos[0];
        realv[i][1] = m[i][0] * rotmatrix[1][0] + m[i][1] * rotmatrix[1][1] + m[i][2] * rotmatrix[1][2] - pos[1];
        realv[i][2] = m[i][0] * rotmatrix[2][0] + m[i][1] * rotmatrix[2][1] + m[i][2] * rotmatrix[2][2] - pos[2];
    }
}

void Droid::Refresh_mechanic()
{
    rvector downvector (0, -speed_free_down, 0);
    rvector delta = downvector - v;
    if (delta.abs() > brakespeed)
    {
        delta.NormalizeTo(brakespeed);
        v = v + delta;
        Normalize_v();
    }
    else
        v = downvector;

    pos += v;

    float Radius = 2.0; // радиус сферы
    float distance = 0.0f;
    int n = gworld->walls.size();
    //("ok, n = %i\n", n);
    for (int j = 0; j < n; ++j)
    {
        rvector vNormal = GetNormal3v3f(gworld->walls[j].v[0].data,
                                        gworld->walls[j].v[2].data,
                                        gworld->walls[j].v[1].data);
        {
            if (ClassifySphere(pos, vNormal, gworld->walls[j].v[0], Radius, distance) == CS_INTERSECTS)
            {
                rvector vOffset = vNormal * distance;
                rvector vIntersection = vOffset - pos;
                if (dbAutoIntersect)
                    printf("+ Intersection have been found:\n vOffset = (%.2f; %.2f; %.2f)\n", vOffset[0], vOffset[1], vOffset[2]);
                if (InsidePolygon(vIntersection, gworld->walls[j].v, 3, 1) || EdgeSphereCollision(pos, gworld->walls[j].v, 3, Radius / 2))
                {
                    if (dbAutoIntersect)
                        printf("+ Inside polygon / edge collision\n");
                    vOffset = GetCollisionOffset(vNormal, Radius, distance);
                    pos = pos + vOffset;
                }
            }
        }
    }

    // Count_real_vertexes();
}

void Droid::GetMove(bool BackOrForward)
{
    float k = (BackOrForward ? 1 : -1);
    float ty = -move_speed * cos((turn[0] - H_angle) * PI_DIV_360);
    float tz =  move_speed * sin((turn[0] - H_angle) * PI_DIV_360);
    float ta = -tz * sin(turn[1] * PI_DIV_360);
    float tb =  tz * cos(turn[1] * PI_DIV_360);
    v[0] += k * ta;
    v[1] += k * ty;
    v[2] += k * tb;

    for (int t = 0; t < 3; ++t)
    {
        rvector newv;
        newv.form(k * ta * speedzoom + RandomD(0.1), k * ty * speedzoom + RandomD(0.1) , k * tb * speedzoom + RandomD(0.1));
        newv.NormalizeTo(newv.abs() + RandomD(0.3));
        Particular newpart (pos, newv);
        gworld->droidparts.push_back(newpart);
    }
}

void Droid::Shoot(int CommandFromMouse)
{
    float a = (-turn[0] + H_angle) * PI_DIV_360,
          b =  -turn[1] * PI_DIV_360;
    float rotmatrix[3][3] =
    {
        { cos(b), sin(a) * sin(b), sin(b)*cos(a)},
        {0,       cos(a),          -sin(a)      },
        {-sin(b), sin(a) * cos(b), cos(a)*cos(b)}
    };

    rvector Speed;
    Speed.form(BulletSpeed * rotmatrix[0][1], BulletSpeed * cos(a), BulletSpeed * rotmatrix[2][1]);
    gworld->CreateBullet(pos, Speed, (CommandFromMouse == GLUT_LEFT_BUTTON ? btLevel1 : btLevel3));
    if (dbAutoBullets)
        printf("+ Bullet created\n");
}

void Droid::SuperMultiShoot()
{
    for (float a = 0.0; a < 180.0; a += 10.0)
        for (float b = 0.0; b < 180.0; b += 10.0)
        {
            float rotmatrix[3][3] =
            {
                { cos(b), sin(a) * sin(b), sin(b)*cos(a)},
                {0,       cos(a),          -sin(a)      },
                {-sin(b), sin(a) * cos(b), cos(a)*cos(b)}
            };

            rvector Speed;
            Speed.form(BulletSpeed * rotmatrix[0][1], BulletSpeed * cos(a), BulletSpeed * rotmatrix[2][1]);
            gworld->CreateBullet(pos, Speed, btLevel1);
        }
    printf("] supermultishoot\n");
}

void Droid::RefreshLightmap()
{
    m3t(light_map[ 0], GetNormal3v3f(m[0], m[2],  m[12]).data);
    m3t(light_map[ 1], GetNormal3v3f(m[1], m[13], m[5] ).data);
    m3t(light_map[ 2], GetNormal3v3f(m[2], m[6],  m[14]).data);
    m3t(light_map[ 3], GetNormal3v3f(m[5], m[15], m[7] ).data);
    m3t(light_map[ 4], GetNormal3v3f(m[0], m[4],  m[1] ).data);
    m3t(light_map[ 5], GetNormal3v3f(m[3], m[7],  m[4] ).data);
    m3t(light_map[ 6], GetNormal3v3f(m[0], m[18], m[2] ).data);
    m3t(light_map[ 7], GetNormal3v3f(m[1], m[5],  m[19]).data);
    m3t(light_map[ 8], GetNormal3v3f(m[2], m[20], m[6] ).data);
    m3t(light_map[ 9], GetNormal3v3f(m[5], m[7],  m[21]).data);
    m3t(light_map[10], GetNormal3v3f(m[0], m[1],  m[9] ).data);
    m3t(light_map[11], GetNormal3v3f(m[6], m[9],  m[7] ).data);
    m3t(light_map[12], GetNormal3v3f(m[3], m[10], m[12]).data);
    m3t(light_map[13], GetNormal3v3f(m[4], m[13], m[11]).data);
    m3t(light_map[14], GetNormal3v3f(m[3], m[12], m[14]).data);
    m3t(light_map[15], GetNormal3v3f(m[4], m[15], m[13]).data);
    m3t(light_map[16], GetNormal3v3f(m[8], m[18], m[16]).data);
    m3t(light_map[17], GetNormal3v3f(m[9], m[17], m[19]).data);
    m3t(light_map[18], GetNormal3v3f(m[8], m[20], m[18]).data);
    m3t(light_map[19], GetNormal3v3f(m[9], m[19], m[21]).data);
}

void Droid::Draw()
{
    glPushMatrix();

        glRotatef(H_angle, 1.0f, 0.0f, 0.0f);
        glRotatef(rot_angle, 0.0f, 1.0f, 0.0f);

        glBegin(GL_QUADS);
            glColor3f(1.0f, 1.0f, 0.95f);

            for (int i = 0; i < 12; ++i)
            {
                glNormal3fv(light_map[i]);
                glVertex3fv(m[quad_vertexes[i][0]]);
                glVertex3fv(m[quad_vertexes[i][1]]);
                glVertex3fv(m[quad_vertexes[i][2]]);
                glVertex3fv(m[quad_vertexes[i][3]]);
            }
        glEnd();

        glBegin(GL_TRIANGLES);
            glColor3f(0.0f, 0.0f, 1.0f);
            for (int i = 0; i < 8; ++i)
            {
                glNormal3fv(light_map[i + 12]);
                glVertex3fv(m[tri_vertexes[i][0]]);
                glVertex3fv(m[tri_vertexes[i][1]]);
                glVertex3fv(m[tri_vertexes[i][2]]);
            }

        glEnd();
        glColor3f(1.0f, 0.0f, 0.0f);
        glPushMatrix();
            glTranslatef(0.9f, 0.3f, 0.0f);
            glRotatef(270.0f, 1.0f, 0.0f, 0.0f);
            glutSolidCone(0.2f, 1.5f, 8, 8);
        glPopMatrix();

        glPushMatrix();
            glTranslatef(-0.9f, 0.3f, 0.0f);
            glRotatef(270.0f, 1.0f, 0.0f, 0.0f);
            glutSolidCone(0.2f, 1.5f, 8, 8);
        glPopMatrix();
    glPopMatrix();
    ///Count_real_vertexes();
}

void Droid::TransformAllTheWorld()
{
    glRotatef(turn[0], 1.0f, 0.0f, 0.0f); // Нужные проеобразования
    glRotatef(turn[1], 0.0f, 1.0f, 0.0f);
    glRotatef(turn[2], 0.0f, 0.0f, 1.0f);
    glTranslatef(-pos[0], -pos[1], -pos[2]);
}
