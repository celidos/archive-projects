#include <iostream>
#include <stdio.h>
#include <string>
#include <vector>

#include "textconsolecolors.h"
#include "master.hpp"
#include "opencv2/objdetect/objdetect.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"

#include "history.h"

using namespace std;
using namespace cv;

RNG rng(12345);

int main(int argc, char *argv[])
{
    cout << endl << "\033[37m             ~ CCAPTCHA checker v. 0.0.0.0 ~           \033[0m" << endl << endl;
	for (int i = 0;i < argc; i++)
		printf("Argument %d: %s\n", i, argv[i]);


    while (true)
    {
        printlsep();
        cout << "Введите название файла (без пути и расширения .jpg): ";
        string addfilename;
        cin >>addfilename;
        if (addfilename == "-!")
            break;
        string imageName = "./sources/"+ addfilename +".jpg";

        ImageAnalysisMaster iMaster;
        iMaster.initFromFile(imageName);
        iMaster.recognize();

//waitKey(0);
        //destroyWindow("Letter");
        //destroyAllWindows();
    }
    return main(argc, argv);//0;
}
