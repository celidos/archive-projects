#include <iostream>
#include <algorithm>
#include <vector>
#include <cstdlib>
#include <cstring>
#include <queue>
#include <map>

#define INF 1000000000
#define lli long long int

#define MAX_N 100500
#define MAX_K 11

using namespace std;

struct lol
{
    lli x;
    int i;
    lol(lli value, int I)
    {
        x = -1;
        i = -1;
    }
};

int main()
{
    lol max11, max3, max33_1, max33_2, max_not33_1, max_not33_2;
    int n;
    lli a;
    cin >> n;
    for (int i = 0; i < n; ++i)
    {
        cin >> a;

        if ((a %3 == 0) && (a%11 != 0) && a > max3.x)
            max3 = lol(a, i);

        if ((a %3 != 0) && (a%11 == 0) && a > max11.x)
            max11 = lol(a, i);

        if ()
    }

    return 0;
}
