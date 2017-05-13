#ifndef MASTER_HPP_INCLUDED
#define MASTER_HPP_INCLUDED

#include <fstream>
#include <string>
#include <iostream>

#include "opencv2/objdetect/objdetect.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"

using namespace std;
using namespace cv;

class ImageAnalysisMaster
{
private:
    string filename;
    Mat image;
public:
    int facesfound;
    int lettersfound;
    bool enoughcontrast;

    ImageAnalysisMaster();

    void setFilename(string NewName) {filename = NewName;};
    string getFilename() {return filename;};

    void initFromFile(string FileName = "$");
    bool recognize();
};


#endif // MASTER_HPP_INCLUDED
