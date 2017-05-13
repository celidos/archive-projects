#include <iostream>
#include <fstream>
#include <algorithm>
#include <vector>
#include <cstdlib>
#include <cstring>
#include <queue>
#include <map>

#define INF 1000000000
#define lli long long int

#define MAX_N 15000

using namespace std;

int jobcost[MAX_N], premium = 0, a[MAX_N];

int main()
{
    freopen("input.txt", "r", stdin);
    freopen("output.txt", "w", stdout);

    int n, t;
    cin >> n;

    for (int i = 0; i < n; ++i)
        cin >> a[i];

    cin >> t;
    for (int tt = 0; tt < t; ++tt)
    {
        int op;
        cin >> op;
        if (op == 1)
        {
            for (int i = 0; i < n; ++i)
                jobcost[i] += a[i];
        }
        else if (op == 2)
        {
            int pr;
            cin >> pr;
            premium += pr;
        }
        else if (op == 3)
        {
            int ans = 0;
            for (int i = 0; i < n; ++i)
                if (jobcost[i] > premium)
                    ++ans;
            cout << ans << endl;
        }
    }
    cout << endl;
    return 0;
}
