#ifndef DROID_H_INCLUDED
#define DROID_H_INCLUDED

#include <GL/gl.h>
#include <GL/glut.h>
#include <stdio.h>

#include "gameworld.h"

class Droid
{
public:
    rvector pos;                // положение
    rvector turn;               // направление корпуса
    rvector v;                  // скорость
    float rot_angle;            // угол вращения вокруг собственной оси
    float H_angle = -90.0f;     // угол видимости дроида

    GameWorld *gworld;

    Droid(): gworld(NULL) {};
    Droid(rvector rvPosition, rvector rvTurn, GameWorld *World);
    ~Droid() {};

    void Normalize_v();                         // ограничить модуль вектора скорости
    void GetMove(bool ForwardOrBack);           // Переместиться вперед/назад
    void Shoot(int CommandFromMouse);           // Выстрелить
    void SuperMultiShoot();
    void Refresh_mechanic();                    // обновить механические свойства дроида
    void Draw();                                // Нарисовать дроид
    void TransformAllTheWorld();
    float realv[10][3];                         // Реальные физические кординаты ключевых вершин многогранника-дроида
private:

    float light_map[20][3];                     // Предрассчитанная карта освещенности
    void RefreshLightmap();                    // Рассчитать карту освещенности. Вызывается однократно
    void CountRealVertexes();                 // Рассчитать реальные координаты дроида
};

const int quad_vertexes[12][4] = {
        {0, 2, 12, 10},
        {1, 5, 13, 11},
        {2, 6, 14, 12},
        {5, 7, 15, 13},
        {0, 1,  4,  3},
        {3, 4,  7,  6},
        {0, 2, 18, 16},
        {1, 5, 19, 17},
        {2, 6, 20, 18},
        {5, 7, 21, 19},
        {0, 1,  9,  8},
        {6, 7,  9,  8}};

const int tri_vertexes[8][4] = {
        {3, 10, 12},
        {4, 11, 13},
        {3, 12, 14},
        {4, 13, 15},
        {8, 16, 18},
        {9, 17, 19},
        {8, 18, 20},
        {9, 19, 21}};

const float m[22][3] = {
        {-0.3f,  2.0f,  0.0f},
        { 0.3f,  2.0f,  0.0f},
        {-1.5f,  0.0f,  0.0f},
        {-0.1f,  0.1f,  0.8f},
        { 0.1f,  0.1f,  0.8f},
        { 1.5f,  0.0f,  0.0f},
        {-0.6f, -1.0f,  0.0f},
        { 0.6f, -1.0f,  0.0f},
        {-0.1f,  0.1f, -0.8f},
        { 0.1f,  0.1f, -0.8f},

        {-0.18f,  0.86f,  0.48f},
        { 0.18f,  0.86f,  0.48f},
        {-0.66f,  0.06f,  0.48f},
        { 0.66f,  0.06f,  0.48f},
        {-0.3f , -0.34f,  0.48f},
        { 0.3f , -0.34f,  0.48f},

        {-0.18f,  0.86f, -0.48f},
        { 0.18f,  0.86f, -0.48f},
        {-0.66f,  0.06f, -0.48f},
        { 0.66f,  0.06f, -0.48f},
        {-0.3f , -0.34f, -0.48f},
        { 0.3f , -0.34f, -0.48f},
    };

const float speed_free_down = 0.05f;
const float speedzoom       = 0.5;


#endif // DROID_H_INCLUDED
