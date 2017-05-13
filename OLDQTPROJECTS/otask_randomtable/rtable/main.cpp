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

#define MAX_N 16

using namespace std;

int M[MAX_N][4];

const int MAX_QUANTUM = 150;
const int RELOAD_TIME = 2;

int main()
{
    int bestans = INF;
    for (int q = 1; q <= MAX_QUANTUM; ++q)
    {
        //cout << " >>> Q = " << q<<endl;
        int curtime = 0;
        int pr[3] = {59, 29, 11};
        int times[3] = {0, 0, 0};

        int _3count = 0;
        int last = 0;
        for (int i = 0; _3count < 3; ++i)
        {
            int cur = i%3;
            if  (pr[cur] == 0)
            {
                ++_3count;
                continue;
            }
            else
            {
                _3count = 0;

                if (last != cur)
                    curtime += RELOAD_TIME;

                if (pr[cur] > q)
                {
                    pr[cur] -= q;
                    curtime += q;
                }
                else
                {
                    curtime += pr[cur];
                    times[cur] = curtime;
                    //cout << "times[" << cur << "] = " << times[cur] << endl;
                    pr[cur] = 0;
                }
                last = cur;
            }
        }

        int curans = 0;
        for (int i = 0; i < 3; ++i)
            curans += times[i];

        if (curans < bestans)
        {
            cout << "We have found better result : q = "<< q<< " (time = " << curans <<")"<< endl;
            bestans = curans;
        }
    }

    return 0;
}
