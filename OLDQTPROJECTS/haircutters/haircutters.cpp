#include "haircutters.h"
#include "ui_haircutters.h"

int StrToTime(string str){
    int h, m;
    std::stringstream linestream(str);
    linestream >> h;
    linestream.ignore();
    linestream >> m;
    return h * 60 + m;
}

string TimeToStr(int time) {
    char ans[7];

    time = abs(time) % 1440;
    std::sprintf(ans, "%02i:%02i", time / 60, time % 60);
    return (const char*) ans;
}

void HairCuttersDatabase::clear(){
    hcutters.clear();
}

void HairCuttersDatabase::searchGoodHaircutter(string hstyle, int &ansMinTimeIndex, int &indexhstyle) {
    ansMinTimeIndex = -1;
    for (int i = 0; i < (int)hcutters.size(); ++i) {
        int localindexhstyle = -1;
        for (int j = 0; j < (int)hcutters[i].hstyles.size() && localindexhstyle == -1; ++j)
            if (hcutters[i].hstyles[j].name == hstyle) {
                localindexhstyle = i;
                break;
            }
        if (localindexhstyle == -1)
            continue;
        else
            cout << "localind = " << localindexhstyle << endl;
        if ((ansMinTimeIndex == -1) ^ (hcutters[i].timeOfFree < hcutters[ansMinTimeIndex].timeOfFree)) {
            indexhstyle = localindexhstyle;
            ansMinTimeIndex = i;
        }
    }
}

void HairCuttersDatabase::loadFromFile(const char *filename, int starttime){
    ifstream in;
    in.open(filename);
    string line;
    hcutters.clear();
    while (std::getline(in, line))
    {
        std::stringstream linestream(line);
        HaircutMaker NewHC;
        NewHC.timeOfFree = starttime;
        linestream >> NewHC.name;
        string newName;
        int time;
        while (linestream >> newName >> time)
        {
            HairStyle hs = {newName, time};
            NewHC.hstyles.push_back(hs);
        }
        hcutters.push_back(NewHC);
    }
    cout << "------------------------------\n";
    cout << "size of db = " << hcutters.size() << endl;
    for (int i = 0; i < (int)hcutters.size(); ++i) {
        cout << hcutters[i].name << "; prichesok umeet delat : " << hcutters[i].hstyles.size() << endl;
    }
    in.close();
}

void HairCuttersDatabase::readBase(const char *basefile, const char *responsefile, int starttime) {
    ifstream in;
    ofstream out;
    in.open(basefile);
    out.open(responsefile);
    string line;
    string clientname, hairstylename;
    for (int i = 0; i < (int)hcutters.size(); ++i) {
        hcutters[i].timeOfFree = starttime;
    }
    while (std::getline(in, line)) {
        std::stringstream linestream(line);
        linestream >> clientname >> hairstylename; //
        int mintimeindex, indexhstyle;

        searchGoodHaircutter(hairstylename, mintimeindex, indexhstyle);

        cout << "mintimeindex == " << mintimeindex << endl;
        if (mintimeindex != -1) {
            hcutters[mintimeindex].timeOfFree += hcutters[mintimeindex].hstyles[indexhstyle].timeInMinutes;
            out << "Время ухода: " << TimeToStr(hcutters[mintimeindex].timeOfFree) << ", клиент " << clientname << " (прическа "<<hairstylename<< "), обслужил " << hcutters[mintimeindex].name << endl;
        } else {
            out << "                    kлиент: " << clientname << " (прическа "<<hairstylename<< "), никто не умеет делать такие прически!" << endl;
        }
    }
    out.close();
    cout << "ok! done." << endl;
}

HairCutters::HairCutters(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::HairCutters)
{
    ui->setupUi(this);
    db = new HairCuttersDatabase;
    QObject::connect(ui->pushButton_4, SIGNAL(clicked()), this, SLOT(slotReadBase()));
    QObject::connect(ui->pushButton,   SIGNAL(clicked()), this, SLOT(openfile1()));
    QObject::connect(ui->pushButton_3, SIGNAL(clicked()), this, SLOT(openfile2()));
    QObject::connect(ui->pushButton_2, SIGNAL(clicked()), this, SLOT(openfile3()));
}

HairCutters::~HairCutters()
{
    delete ui;
}

void HairCutters::slotReadBase(){
    db->loadFromFile(ui->lineEdit_3->text().toStdString().c_str(), StrToTime(ui->lineEdit_4->text().toStdString()));
    db->readBase(ui->lineEdit->text().toStdString().c_str(),
                 ui->lineEdit_2->text().toStdString().c_str(),
                 StrToTime(ui->lineEdit_4->text().toStdString()));
}

void HairCutters::openfile1() {
    ui->lineEdit->setText(QFileDialog::getOpenFileName(0, "Choose File with HairCutters", "", "*.txt"));
}

void HairCutters::openfile2() {
    ui->lineEdit_3->setText(QFileDialog::getOpenFileName(0, "Choose File with HairCutters", "", "*.txt"));
}

void HairCutters::openfile3() {
    ui->lineEdit_2->setText(QFileDialog::getOpenFileName(0, "Choose File with HairCutters", "", "*.txt"));
}

