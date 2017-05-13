#include "bsp.h"

int buildingprogress = 0;
int percents = 0;
clock_t timer;

void BSP::Build(vector <Wall> &W)
{
    printf("\n\n] BSP building... \n");
    buildingprogress = 0;
    percents = 0;
    timer = clock();

    nodes_size = W.size();
    vector <int> indexes (W.size());
    for (int i = W.size() - 1; i; --i)
        indexes[i] = i;
    memset(Nodes, -1, sizeof(int) * MAX_BSP_ELEMENTS);
    Build(indexes, W, 0);
    timer = clock() - timer;
    printf("... success (it took ~ %i sec)\n", timer / CLOCKS_PER_SEC);
}

void BSP::Build(vector <int> wIndexes, vector <Wall> &W, int node) // Очень ёмкая операция (сложность O(4*N*N*log(N)), зато однократная
// 40 тыс. полигонов - 13 минут 13 секунд (793 сек)

{
    //printf("bsp called with wIndexes.size = %i; Walls.size = %i; node = %i\n", wIndexes.size(), W.size(), node);
    if (wIndexes.size() > 0)
    {
        int score = 1000000000;
        int bestwallindex = 0;
        for (int t = wIndexes.size() - 1; t >= 0; --t)
        {
            //printf("now let's check wIndexes[%i] = %i\n", t, wIndexes[t]);
            int tofront = 0;
            int toback  = 0;
            for (int y = wIndexes.size() - 1; y >= 0; --y)
            {
                bool wasfront = false, wasback = false;
                if (t != y)
                    for (int j = 0; j < W[wIndexes[y]].vcount; ++j)
                    {
                        /*printf("let's think about (%.2f; %.2f; %.2f); (%.2f; %.2f; %.2f); (%.2f; %.2f; %.2f); (%.2f; %.2f; %.2f)\n",
                        W[wIndexes[t]].v[0].data[0], W[wIndexes[t]].v[0].data[1], W[wIndexes[t]].v[0].data[2],
                        W[wIndexes[t]].v[1].data[0], W[wIndexes[t]].v[1].data[1], W[wIndexes[t]].v[1].data[2],
                        W[wIndexes[t]].v[2].data[0], W[wIndexes[t]].v[2].data[1], W[wIndexes[t]].v[2].data[2],
                        W[wIndexes[y]].v[j].data[0], W[wIndexes[y]].v[j].data[1], W[wIndexes[y]].v[j].data[2]);
                        printf("%.3f\n", plat_turn(W[wIndexes[t]].v[0].data,
                                             W[wIndexes[t]].v[1].data,
                                             W[wIndexes[t]].v[2].data,
                                             W[wIndexes[y]].v[j].data));*/
                        if (plat_turn(W[wIndexes[t]].v[0].data,
                                             W[wIndexes[t]].v[1].data,
                                             W[wIndexes[t]].v[2].data,
                                             W[wIndexes[y]].v[j].data) > 0)
                           // {
                            wasfront = true;
                            //printf("                                          result = 1\n");}
                        else
                           // {
                            wasback = true;
                            //printf("                                          result = 0\n");}

                    }
                if (wasfront)
                    ++tofront;
                if (wasback)
                    ++toback;
            }
            //printf("while choosing we get tofront = %i; toback = %i\n", tofront, toback);
            if (abs(tofront - toback) < score)
            {
                score = abs(tofront - toback);
                bestwallindex = wIndexes[t];
            }

        }
        //printf("best chosen index = %i\n", bestwallindex);

        Wall BreakPoly = W[bestwallindex];
        Nodes[node] = bestwallindex;
        ++buildingprogress;
        if (buildingprogress * 100 / nodes_size > percents)
        {
            percents = buildingprogress * 100 / nodes_size;
            printf("] progress : %3i\n", percents);
        }


        vector <int> tofront;
        vector <int> toback;
        for (int i = wIndexes.size() - 1; i >= 0; --i)
        {
            bool wasfront = false, wasback = false;
            if (wIndexes[i] != bestwallindex)
            {
                for (int j = 0; j < W[wIndexes[i]].vcount; ++j)
                {
                    if (plat_turn(BreakPoly.v[0].data,
                                          BreakPoly.v[1].data,
                                          BreakPoly.v[2].data,
                                          W[wIndexes[i]].v[j].data)
                                          > 0)
                            //{
                            wasfront = true; //printf("                                          result = 1\n");}
                        else
                            //{
                            wasback = true; //printf("                                          result = 0\n");}
                }
                if (wasfront)
                {
                    tofront.push_back(wIndexes[i]);
                    //printf("    front %i\n", i);
                }
                if (wasback)
                {
                    toback.push_back(wIndexes[i]);
                    //printf("    back %i;\n", i);
                }
            }
        }
        /*printf("We got the path...\n ");
        for (int t = 0; t < tofront.size(); ++t )
            printf(" %i", tofront[t]);
        //printf("\n* * *\n ");
        printf("  //  ");
                for (int t = 0; t < toback.size(); ++t )
            printf(" %i", toback[t]);
            printf("\n");

*/
        Build(tofront, W, 2*node + 1);
        Build(toback,  W, 2*node + 2);
    }
    //printf("we have even exited!\n");
}
