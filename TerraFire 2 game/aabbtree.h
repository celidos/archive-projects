#ifndef AABBTREE_H_INCLUDED
#define AABBTREE_H_INCLUDED

#include <algorithm>

#include "physics.h"
#include "wall.h"

using std::min;
using std::max;
/*
struct TRIANGLE  // тройка вершин
{
  POINT3D V[3]; // класс POINT3D смотри в "Определение столкновений выпуклых объектов
                // движущихся с постоянными скоростями".

  TRIANGLE& operator *= ( const MATRIX& m ) {  // MATRIX - матрица 4x4
    for( int i=0; i<3; ++i ) V[i]*=m; return *this;
  }
};

struct AABB // "бокс", лежащий вдоль осей координат
{
    rvector Min, Max;

    AABB(const rvector &Min_ = rvector(0, 0, 0), const rvector& Max_= rvector(0,0,0) ) :
        Min(Min_), Max(Max_) {}

    rvector Size() const {return Max - Min;}

    void EnlargeMe(const Wall& OurWall)
    {
        for (int i = 0; i < 3; ++i)
        {
            Min[0] = min(Min[0], OurWall.v[i][0]);
            Min[1] = min(Min[1], OurWall.v[i][1]);
            Min[2] = min(Min[2], OurWall.v[i][2]);

            Max[0] = max(Max[0], OurWall.v[i][0]);
            Max[1] = max(Max[1], OurWall.v[i][1]);
            Max[2] = max(Max[2], OurWall.v[i][2]);
        }
    }

    bool operator > ( const AABB& b ) const; //Сравнивает размеры двух "боксов"
};


class AABB_TREE
{
public:
  AABB_TREE() : pRootNode(NULL) {}
  ~AABB_TREE() { RecursiveSuicide(pRootNode); }

  // Строит AABB tree по списку треугольников, представленных тройками вершин,
  // итераторы указывают на неконстантные объекты для упрощения,
  // вершины будут перемещены
  void Build( Wall* const pBeginT, Wall* const pEndT );

  // Методы, проверяющие пересечение с примитивами.
  bool TestIntersection( const class RAY& Ray, class POINT3D& Position,
                         class POINT3D& Normal ) const;

  template <class GEOM_PRIMITIVE>
  bool TestIntersection( const GEOM_PRIMITIVE& gp ) const {
    return pRootNode ? RecursiveTestIntersection(pRootNode,gp) : false;
  }

  // Метод, проверяющий пересечение с другим объектом класса AABB_TREE.
  // m - матрица перехода из системы координат ABBTree в систему координат *this.
  bool TestIntersection( const AABB_TREE& ABBTree, const MATRIX& m ) const;

private:
  struct NODE;

  NODE* pRootNode;

  AABB_TREE( const AABB_TREE& ); // запрещаем копирование
  AABB_TREE& operator=( const AABB_TREE& ); // запрещаем присваивание

  void RecursiveSuicide( NODE* const pNode );
  bool IsPositiveTriangle( const TRIANGLE* const pT, const AABB& B,
                           const int IndexOfMaxBoxDimension ) const;
  void RecursiveBuild( NODE*& pNode, TRIANGLE* const pBeginT, TRIANGLE* const pEndT );
  template <class GEOM_PRIMITIVE>
  bool RecursiveTestIntersection( const NODE* const pNode,
                                  const GEOM_PRIMITIVE& gp ) const;
  void MakeOBBFromAABBAndMatrix( class OBB& obb, const AABB& aabb, const MATRIX& m ) const;
  bool RecursiveTestIntersection( const NODE* const pMyNode, const NODE* const pOutsideNode,
                                  const MATRIX& m ) const;
};

// Класс NODE содержит и Box и Triangle. Это сделано исключительно для упрощения,
// в коммерческой реализации надо оптимизировать расход памяти.
struct AABB_TREE::NODE
{
  AABB Box;
  TRIANGLE Triangle;
  NODE* pPositive, * pNegative;

  NODE() : pPositive(NULL), pNegative(NULL) {}

  bool IsLeaf() const {
    assert( (!pPositive&&!pNegative) || (pPositive&&pNegative) );
    return !pPositive;
  }
};

 // Рекурсивно "рубит" дерево
void AABB_TREE::RecursiveSuicide( NODE* const pNode )
{
  if( pNode )
  {
    RecursiveSuicide(pNode->pPositive);
    RecursiveSuicide(pNode->pNegative);
    delete pNode;
  }
};

void AABB_TREE::Build( TRIANGLE* const pBeginT, TRIANGLE* const pEndT )
{
  RecursiveSuicide(pRootNode);
  pRootNode=NULL;

  if( pBeginT!=pEndT )
    RecursiveBuild(pRootNode,pBeginT,pEndT);
}

// Относит треугольник к позитивному или негативному множеству
bool AABB_TREE::IsPositiveTriangle( const TRIANGLE* const pT, const AABB& B,
                                    const int IndexOfMaxBoxDimension ) const
{
  const POINT3D* const V=pT->V;
  const float C_0=V[0][IndexOfMaxBoxDimension], C_1=V[1][IndexOfMaxBoxDimension],
              C_2=V[2][IndexOfMaxBoxDimension],
              MinC=std::min(std::min(C_0,C_1),C_2), MaxC=std::max(std::max(C_0,C_1),C_2),
              MiddlePointOfBox=(B.Min[IndexOfMaxBoxDimension]+B.Max[IndexOfMaxBoxDimension])*0.5f,
              MiddlePointOfTriangleProj=(MinC+MaxC)*0.5f;
  return MiddlePointOfTriangleProj>MiddlePointOfBox;
}

// Рекурсивно строит дерево
void AABB_TREE::RecursiveBuild( NODE*& pNode, TRIANGLE* const pBeginT, TRIANGLE* const pEndT )
{
  assert( pBeginT<pEndT );
  assert( pNode==NULL );

  pNode=new NODE;

  if( pEndT-pBeginT==1 )
  { //Это лист
    pNode->Triangle=*pBeginT;
  }
  else
  {
    // Вычисляем "бокс"
    AABB Box(POINT3D(FLT_MAX,FLT_MAX,FLT_MAX),POINT3D(-FLT_MAX,-FLT_MAX,-FLT_MAX));
    for( const TRIANGLE* pT=pBeginT; pT!=pEndT; ++pT ) Box.EnlargeMe(*pT);

    // Ищем максимальный размер
    int IndexOfMaxBoxDimension=0; const POINT3D Size(Box.Size()); float MaxBoxDimension=Size[0];
    for( int i=1; i<3; ++i ) if( Size[i]>MaxBoxDimension ) {
      MaxBoxDimension=Size[i]; IndexOfMaxBoxDimension=i;
    }

    // Делим треугольники на два подмножества
    TRIANGLE* pEndNegative=pBeginT, * pBeginPositive=pEndT;
    for( ; pEndNegative!=pBeginPositive; )
      if( IsPositiveTriangle(pEndNegative,Box,IndexOfMaxBoxDimension) )
        std::swap(*pEndNegative,*(--pBeginPositive));
      else
        pEndNegative++;

    // Подмножество может оказаться пустым.
    // Для борьбы с эти ассертом надо выбрать наибольший треугольник
    // и отправить его в пустое подмножество.
    assert( pBeginT<pEndNegative && pEndNegative==pBeginPositive && pBeginPositive<pEndT );

    pNode->Box=Box;

    // Продолжаем рекурсию
    RecursiveBuild(pNode->pNegative,pBeginT,pEndNegative);
    RecursiveBuild(pNode->pPositive,pBeginPositive,pEndT);
  }
}

// Шаблонная функция-член класса, проверяет рекурсивно пересечение примитива с AABB tree
template <class GEOM_PRIMITIVE>
bool AABB_TREE::RecursiveTestIntersection( const NODE* const pNode,
                                           const GEOM_PRIMITIVE& gp ) const
{
  assert( pNode );

  if( pNode->IsLeaf() )
    return ::TestIntersection(pNode->Triangle,gp);
  else if( ::TestIntersection(pNode->Box,gp) )
    return RecursiveTestIntersection(pNode->pPositive,gp) ||
           RecursiveTestIntersection(pNode->pNegative,gp);

  return false;
}

bool AABB_TREE::TestIntersection( const AABB_TREE& ABBTree, const MATRIX& m ) const
{
  if( pRootNode && ABBTree.pRootNode )
    return RecursiveTestIntersection(pRootNode,ABBTree.pRootNode,m);

  return false;
}

// Делает из AABB и матрицы OBB
void AABB_TREE::MakeOBBFromAABBAndMatrix( class OBB& obb, const AABB& aabb,
                                          const MATRIX& m ) const
{
  // Не привожу реализацию для экономии места
}

// Рекурсивно проверяет пересечение двух деревьев.
// m - матрица перехода из системы координат pOutsideNode в систему координат pMyNode.
bool AABB_TREE::RecursiveTestIntersection( const NODE* const pMyNode,
                                           const NODE* const pOutsideNode, const MATRIX& m )const
{
  if( pMyNode->IsLeaf() )
  {
    // pMyNode-лист, pOutsideNode-узел или лист
    TRIANGLE Triangle(pMyNode->Triangle); Triangle*=m.GetInverse();
    return RecursiveTestIntersection(pOutsideNode,Triangle);
  }
  else
  {
    if( pOutsideNode->IsLeaf() )
    {// pMyNode-узел, pOutsideNode-лист
      TRIANGLE Triangle(pOutsideNode->Triangle); Triangle*=m;
      return RecursiveTestIntersection(pMyNode,Triangle);
    }
    else
    {// оба узлa
      if( pMyNode->Box>pOutsideNode->Box ) // не совсем корректное (без учета матрицы m)
                                           // сравнение размеров "боксов"
      {
        return RecursiveTestIntersection(pMyNode->pPositive,pOutsideNode,m)
            || RecursiveTestIntersection(pMyNode->pNegative,pOutsideNode,m);
      }
      else
      {
        return RecursiveTestIntersection(pMyNode,pOutsideNode->pPositive,m)
            || RecursiveTestIntersection(pMyNode,pOutsideNode->pNegative,m);
      }
    }
  }
}*/

#endif // AABBTREE_H_INCLUDED
