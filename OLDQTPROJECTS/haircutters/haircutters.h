#ifndef HAIRCUTTERS_H
#define HAIRCUTTERS_H

#include <QMainWindow>
#include <QString>
#include <QFileDialog>
#include <string>
#include <vector>
#include <fstream>
#include <sstream>
#include <cstdio>
#include <iostream>


using namespace std;

namespace Ui {
class HairCutters;
}

struct HairStyle {
    string name;
    int timeInMinutes;
};

struct HaircutMaker
{
    string name;
    vector <HairStyle> hstyles;
    int curTime;
    int timeOfFree;
};

class HairCuttersDatabase
{
public:
    HairCuttersDatabase(){};
    ~HairCuttersDatabase(){};
    void clear();
    void loadFromFile(const char *filename, int starttime);
    void readBase(const char *basefile, const char *responsefile, int starttime = 480);
private:
    vector <HaircutMaker> hcutters;
    void searchGoodHaircutter(string hstyle, int &ans, int &indexhstyle);
};

int StrToTime(string str);
string TimeToStr(int time);

class HairCutters : public QMainWindow
{
    Q_OBJECT

public:
    explicit HairCutters(QWidget *parent = 0);

    ~HairCutters();

private:
    Ui::HairCutters *ui;
    HairCuttersDatabase *db;
public slots:
    void slotReadBase();
    void openfile1();
    void openfile2();
    void openfile3();

};

#endif // HAIRCUTTERS_H
