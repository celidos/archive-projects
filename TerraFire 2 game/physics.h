#ifndef PHYSICS_H_INCLUDED
#define PHYSICS_H_INCLUDED

#include <stdio.h>
#include <math.h>

#include "vectormath.h"

const int CS_INTERSECTS = 1;
const int CS_FRONT      = 2;
const int CS_BEHIND     = 3;

rvector ClosestPointOnLine  (rvector vA, rvector vB, rvector vPoint);
float   PlaneDistance       (rvector &vNormal, rvector &vPoint);
int     ClassifySphere      (rvector &vCenter, rvector &vNormal, rvector &vPoint, float radius, float &distance);
bool    EdgeSphereCollision (rvector &vCenter, rvector vPolygon[], int vertexCount, float radius);
bool    InsidePolygon       (rvector vIntersection, rvector Poly[], long verticeCount, float param);
rvector GetCollisionOffset  (rvector &vNormal, float radius, float distance);
rvector GetNormal           (rvector vPoly[]);
bool    IntersectedPlane    (rvector vPoly[], rvector vLine[], rvector &vNormal, float &originDistance);
rvector IntersectionPoint   (rvector vNormal, rvector vLine[], double distance);
bool    IntersectedPolygon  (rvector vPoly[], rvector vLine[], int verticeCount, rvector &Pos);
bool    SimpleLineSphereCollision(rvector &vCenter, float radius, rvector startpos, rvector endpos);
float   plat_turn(float * a, float * b, float * c, float * x);

#endif // PHYSICS_H_INCLUDED
