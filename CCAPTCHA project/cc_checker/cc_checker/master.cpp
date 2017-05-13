#include "master.hpp"
#include "CDI.h"
#include "HfH.h"

extern String face_cascade_name;
extern CascadeClassifier face_cascade;

bool FileExists(const string &path)
{
    return std::ifstream(path.c_str()).good();
}

ImageAnalysisMaster::ImageAnalysisMaster()
{
    facesfound = 0;
    lettersfound = 0;
    if (!face_cascade.load(face_cascade_name))
        throw "Error : Error in loading facecascade!";
}

void ImageAnalysisMaster::initFromFile(string FileName)
{

    if (FileName != "$")
        filename = FileName;

    if (FileExists(filename))
    {
        image = imread(FileName, CV_LOAD_IMAGE_COLOR);
        if (!image.data)
        {
            throw "Error : image data is absent!";
            return;
        }
    }
    else
    {
        throw "Error : file '" + FileName + "' doen't exist!";
        return;
    }
}

bool ImageAnalysisMaster::recognize()
{
    cout << "Начинаем обработку..." << endl;


    cout << "Проверяем картинку на контрастность и красочность... \n";
    DetectFooty_method1(image, enoughcontrast, true);
    //cout << "Проверяем картинку на контрастность и красочность... \n";
    //DetectFooty_method2(image, enoughcontrast, true);

    cout << "Ищем лица... ";
    DetectFaces(image, facesfound, true);
    if (!facesfound)
        cout << "\033[32mне найдены\033[0m\n";
    else
        cout << "\033[31mнайдено " << facesfound << " шт. \033[0m\n";
    cout << "Ищем текст... ";
    DetectLetters(image, lettersfound, true);
    if (!lettersfound)
        cout << "\033[32mне найдены\033[0m\n";
    else
        cout << "\033[31mнайдено " << lettersfound << " шт. \033[0m\n";
}
