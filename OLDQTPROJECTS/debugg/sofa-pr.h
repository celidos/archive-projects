#ifndef SOFAPR_H
#define SOFAPR_H

#include <list>
#include <cmath>

using namespace std;

#define FLOAT float

struct v2d
{
    FLOAT x;
    FLOAT y;

    v2d(FLOAT X = 0, FLOAT Y = 0): x(X), y(Y) {};

    v2d operator +(v2d &b){
        return v2d(x+b.x, y+b.y);
    }

    v2d operator -(v2d &b){
        return v2d(x-b.x, y-b.y);
    }

    void operator +=(v2d &b){
        x += b.x;
        y += b.y;
    }

    void operator -=(v2d &b){
        x -= b.x;
        y -= b.y;
    }

    FLOAT scalar(FLOAT X, FLOAT Y) {
        return x*X + y*Y;
    }

    FLOAT scalar(v2d &b){
        return x*b.x + y*b.y;
    }

    FLOAT scalar(v2d *b){
        return x*b->x + y*b->y;
    }

    FLOAT pscalar(FLOAT X, FLOAT Y) {
        return x*Y - X*y;
    }

    FLOAT pscalar(v2d &b){
        return x*b.y - y*b.x;
    }

    FLOAT pscalar(v2d *b){
        return x*b->y - y*b->x;
    }

    FLOAT len2(){
        return x*x + y*y;
    }

    FLOAT len(){
        return sqrt(x*x  + y*y);
    }
};

class Polygon
{
public:
    list <v2d> v;           // Вершины

    Polygon ();
    ~Polygon ();

    FLOAT getS();           // Получить площадь
};

#endif // SOFAPR_H

