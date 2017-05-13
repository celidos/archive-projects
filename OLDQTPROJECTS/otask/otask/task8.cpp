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

int main()
{
    freopen("input.txt", "r", stdin);
    freopen("output.txt", "w", stdout);

    int n, a, b, c;

    cin >> n >> a >> b >> c;

    int maxa = 0, maxb = 0, maxc = 0;
    int maxsum = 0;
    bool found = false;
    for (int i = 0; i <= n; ++i)
    {
        int n1 = n - a*i;
        for (int j = 0; j <= n1; ++j)
        {
            int n2 = n1 - b*j;
            if (n2 >= 0)
            {
                if (n2 % c == 0)
                {
                    int k = n2 / c;
                    if (i + j + k > maxsum)
                    {
                        found = true;
                        maxsum = i + j + k;
                        maxa = i;
                        maxb = j;
                        maxc = k;
                    }
                }
            }
        }
    }

    if (found)
    {
        cout << "YES" << endl << maxa << " " << maxb << " " <<maxc << endl;
    }
    else
    {
        cout << "NO" << endl;
    }

    return 0;
}
