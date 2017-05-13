#include "physics.h"


extern bool dbAutoWallDistances;
extern bool dbAutoBullets;
extern bool dbAutoIntersect;

/// http://www.gamedev.ru/code/articles/?id=4209
// ====== Ближайшая точка на прямой =======
rvector ClosestPointOnLine(rvector vA, rvector vB, rvector vPoint)
{
    rvector vVector1 = vPoint - vA;
    rvector vVector2 = vB - vA;
    vVector2.NormalizeTo(1);
    float d = Distance(vA, vB);
    float t = vVector2.ScalarP(vVector1);

    if (t <= 0) return vA;
    if (t >= d) return vB;

    rvector vVector3 = vVector2 * t;
    rvector vClosestPoint = vA + vVector3;
    return vClosestPoint;
}
// ====== Расстояние от точки до плоскости ======
float PlaneDistance(rvector &vNormal, rvector &vPoint)
{
    float A = vNormal[0],                         /// http://www.nuru.ru/mat/alg/a012.htm
          B = vNormal[1],
          C = vNormal[2];
    float D = - A*vPoint[0] - B*vPoint[1] - C*vPoint[2];
    return fabs(D) / sqrt(qw(A) + qw(B) + qw(C)); /// http://ru.onlinemschool.com/math/assistance/cartesian_coordinate/p_plane/
}
// ====== Определение положения сферы относительно плоскости ======
int ClassifySphere(rvector &vCenter, rvector &vNormal, rvector &vPoint, float radius, float &distance)
{
    float d = PlaneDistance(vNormal, vPoint); // расстояние от начала координат до плоскости
    distance = (vNormal[0] * vCenter[0] + vNormal[1] * vCenter[1] + vNormal[2] * vCenter[2] + d);
    if (dbAutoWallDistances)
        printf ("d = %.2f\n", distance);
    if (fabs(distance) < radius)
        return CS_INTERSECTS;
    else if (distance >= radius)
        return CS_FRONT;
    return CS_BEHIND;
}
// ====== Проверка пересечения сферы с ребром полигона ======
bool EdgeSphereCollision(rvector &vCenter, rvector vPolygon[], int vertexCount, float radius)
{
    rvector vPoint;
    for (int i = 0; i < vertexCount; i++)
    {
        vPoint = ClosestPointOnLine(vPolygon[i], vPolygon[(i + 1) % vertexCount], vCenter);
        float distance = Distance(vPoint, vCenter);
        if (distance < radius)
            return true;
    }
    return false;
}
// ====== Проверка принадлежности точки полигону ======
bool InsidePolygon(rvector vIntersection, rvector Poly[], long verticeCount, float param)
{
    const double MATCH_FACTOR = 0.99;
    double Angle = 0.0;
    rvector vA, vB;
    for (int i = 0; i < verticeCount; i++)
    {
        vA =  (vIntersection * param) + Poly[i];
        vB =  vIntersection * param + Poly[(i + 1) % verticeCount]; /// -
        Angle += AngleBetweenVectors(vA, vB);
        if (dbAutoIntersect)
            printf ("angle between vectors (%.2f; %.2f; %.2f) & (%.2f; %.2f; %.2f) = %.2f\n", vA[0], vA[1], vA[2], vB[0], vB[1], vB[2], AngleBetweenVectors(vA, vB));
    }
    //printf ("a between v = %.2f\n", Angle );
    if (Angle >= (MATCH_FACTOR * (2.0 * M_PI)) )
        return true;
    return false;
}
// ====== Нахождение смещения, для движения центра сферы от пересеченного полигона ======
rvector GetCollisionOffset(rvector &vNormal, float radius, float distance)
{
    rvector vOffset;
    vOffset.form(0.0, 0.0, 0.0);
    if (distance > 0)
    {
        float distanceOver = radius - distance;
        vOffset = vNormal * distanceOver;
    }
    else
    {
        float distanceOver = radius + distance;
        vOffset = vNormal * (- distanceOver);
    }
    return vOffset;
}
// ====== Получить нормаль к полигону ======
rvector GetNormal (rvector vPoly[])
{
    rvector a = vPoly[1] - vPoly[0];
    rvector b = vPoly[2] - vPoly[0];
    rvector ans = a * b;
    ans.NormalizeTo(1);
    return ans;
}
// ====== Проверка на пересечение прямой и плоскости ======
bool IntersectedPlane(rvector vPoly[], rvector vLine[], rvector &vNormal, float &originDistance)
{ //                       полигон    массив из 2 точек  вектор нормали
    float distance1 = 0, distance2 = 0;
    vNormal = GetNormal3v3f(vPoly[0].data,vPoly[2].data, vPoly[1].data);
    originDistance = PlaneDistance(vNormal, vPoly[0]);

    distance1 = ((vNormal[0] * vLine[0][0]) + (vNormal[1] * vLine[0][1]) + (vNormal[2] * vLine[0][2])) + originDistance;
    distance2 = ((vNormal[0] * vLine[1][0]) + (vNormal[1] * vLine[1][1]) + (vNormal[2] * vLine[1][2])) + originDistance;
//printf("dist1 = %f; dist2 = %f\n", distance1, distance2);
    if (distance1 * distance2 >= 0) return false;
    return true;
}
// ====== Нахождение точки пересечения прямой и плоскости ======
rvector IntersectionPoint(rvector vNormal, rvector vLine[], double distance)
{
    rvector vPoint, vLineDir;
    double Numerator = 0.0, Denominator = 0.0, dist = 0.0;

    vLineDir = vLine[1] - vLine[0];
    vLineDir = vLineDir.NormalizeTo(1);

    Numerator   = - (vNormal[0] * vLine[0][0] + vNormal[1] * vLine[0][1] + vNormal[2] * vLine[0][2] + distance);
    Denominator = vNormal.ScalarP(vLineDir);

    if (Denominator == 0.0)
        return vLine[0];
    dist = Numerator / Denominator;

    vPoint[0] = (float)(vLine[0][0] + (vLineDir[0] * dist));
    vPoint[1] = (float)(vLine[0][1] + (vLineDir[1] * dist));
    vPoint[2] = (float)(vLine[0][2] + (vLineDir[2] * dist));

    return vPoint;
}
// ====== Проверка пересечения прямой и полигона ======
bool IntersectedPolygon(rvector vPoly[], rvector vLine[], int verticeCount, rvector & Pos)
{
    rvector vNormal;
    float originDistance = 0;

    if (!IntersectedPlane(vPoly, vLine, vNormal, originDistance))
    {
        //printf("  Даже близко не...\n"); // ============================================
        return false;
    }

    rvector vIntersection = IntersectionPoint(vNormal, vLine, originDistance);
    if (dbAutoIntersect)
        printf ("  We get that vIntersection (%0.3f; %0.3f; %0.3f)\n", vIntersection[0], vIntersection[1], vIntersection[2]);
    if (InsidePolygon(vIntersection, vPoly, verticeCount, -1))
    {
        Pos = vIntersection;
        return true;
    }

    return false;
}

// ====== Проверка пересечения сферы с ребром полигона ======
bool SimpleLineSphereCollision(rvector &vCenter, float radius, rvector startpos, rvector endpos)
{
    rvector vPoint;
    vPoint = ClosestPointOnLine(startpos, endpos, vCenter);
    float distance = Distance(vPoint, vCenter);
    if (distance < radius)
        return true;

    return false;
}

// ===== Ориентация точки относительно плоскости: front/back
float plat_turn(float * a, float * b, float * c, float * x)
{
    float a21 = b[0] - a[0],
          a22 = b[1] - a[1],
          a23 = b[2] - a[2],
          a31 = c[0] - a[0],
          a32 = c[1] - a[1],
          a33 = c[2] - a[2];
    float A = (a22 * a33 - a23 * a32),
          B = (a23 * a31 - a21 * a33),
          C = (a21 * a32 - a22 * a31);
    float D = - a[0]*A - a[1]*B - a[2]*C;
    float ans = A*x[0] + B*x[1] + C*x[2] + D;
    return ans;

}
