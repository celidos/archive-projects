#ifndef FOOTYDETECTOR_HPP_INCLUDED
#define FOOTYDETECTOR_HPP_INCLUDED

#include "opencv2/opencv.hpp"
//#include "opencv2/highgui/highgui.hpp"
//#include "opencv2/imgproc/imgproc.hpp"
#include <vector>
#include <algorithm>
#include <string.h>
#include <iostream>
#include <stdio.h>

/*

Два метода :
1) Простой:
        Определение преобладающих цветов на изображении
         через пространство HSV
        Накопление данных по соответствующим цветам из RGB
2) Метод k-средних

 */

#define RECT_COLORS_SIZE 10

// получение пикселя изображения (по типу картинки и координатам)
#define CV_PIXEL(type,img,x,y) (((type*)((img)->imageData+(y)*(img)->widthStep))+(x)*(img)->nChannels)

// "Типичные" цвета
enum {cBLACK=0, cWHITE, cGREY, cRED, cORANGE, cYELLOW, cGREEN, cAQUA, cBLUE, cPURPLE, NUM_COLOR_TYPES};
char* sCTypes[NUM_COLOR_TYPES] = {"Black", "White","Grey","Red","Orange","Yellow","Green","Aqua","Blue","Purple"};
uchar cCTHue[NUM_COLOR_TYPES] =    {0,       0,      0,     0,     20,      30,      60,    85,   120,    138   };
uchar cCTSat[NUM_COLOR_TYPES] =    {0,       0,      0,    255,   255,     255,     255,   255,   255,    255   };
uchar cCTVal[NUM_COLOR_TYPES] =    {0,      255,    120,   255,   255,     255,     255,   255,   255,    255   };

typedef unsigned int uint;
typedef unsigned char uchar;

// Число пикселей данного цвета на изображении. Должен быть равен 0
uint colorCount[NUM_COLOR_TYPES];

// Определяет, какому из характерных цветов относится данных.
// Возвращает colorType между 0 и NUM_COLOR_TYPES.

int getPixelColorType(int H, int S, int V)
{
    int color = cBLACK;

    if (V < 75)
        color = cBLACK;
    else if (V > 190 && S < 27)
        color = cWHITE;
    else if (S < 53 && V < 185)
        color = cGREY;
    else
    {
        if (H < 7)
            color = cRED;
        else if (H < 25)
            color = cORANGE;
        else if (H < 34)
            color = cYELLOW;
        else if (H < 73)
            color = cGREEN;
        else if (H < 102)
            color = cAQUA;
        else if (H < 140)
            color = cBLUE;
        else if (H < 170)
            color = cPURPLE;
        else                // Прошли круг
            color = cRED;   // Вернулись к красному цвету
    }
    return color;
}

// Cортировка цветов по количеству
bool colors_comparation(std::pair< int, uint > a, std::pair< int, uint > b)
{
    return (a.second > b.second);
}

void DetectFooty_method1(Mat img, bool &resultpaste, bool DisplayOrNot = false)
{
    IplImage *hsv = 0, *dst = 0, *dst2 = 0, *color_indexes = 0, *dst3 = 0;

    // Преобразуем к HSV (Hue - тон, Saturation - насыщенность, Value - значение)
    hsv = cvCreateImage(img.size(), IPL_DEPTH_8U, 3);

    IplImage tmp = img;
    cvCvtColor(&tmp, hsv, CV_BGR2HSV);

    // картинки для хранения результатов
    dst = cvCreateImage(img.size(), IPL_DEPTH_8U, 3);
    dst2 = cvCreateImage(img.size(), IPL_DEPTH_8U, 3);
    color_indexes = cvCreateImage(img.size(), IPL_DEPTH_8U, 1); // Для хранения индексов цвета

    // для хранения RGB-х цветов
    CvScalar rgb_colors[NUM_COLOR_TYPES];

    int i = 0, j = 0, x = 0, y = 0;

    // Обнуляем цвета
    for (int i = 0; i < NUM_COLOR_TYPES; ++i)
        rgb_colors[i] = cvScalarAll(0);

    cout << "we get that w = " << hsv->width << "; h = " << hsv->height << endl;
    for (int y = 0; y < hsv->height; ++y) {
        for (int x = 0; x < hsv->width; ++x) {
            cout << "x = " << x << "; y = " << y << endl;
            // Получаем HSV-компоненты пикселя
            uchar H = CV_PIXEL(uchar, hsv, x, y)[0];        // Hue
            uchar S = CV_PIXEL(uchar, hsv, x, y)[1];        // Saturation
            uchar V = CV_PIXEL(uchar, hsv, x, y)[2];        // Value (Brightness)

            // Определяем, к какому цвету можно отнести данные значения
            int ctype = getPixelColorType(H, S, V);

            // Устанавливаем этот цвет у отладочной картинки
            CV_PIXEL(uchar, dst, x, y)[0] = cCTHue[ctype];  // Hue
            CV_PIXEL(uchar, dst, x, y)[1] = cCTSat[ctype];  // Saturation
            CV_PIXEL(uchar, dst, x, y)[2] = cCTVal[ctype];  // Value
            //cout << "ok! " << endl;
            //cout << ctype << " = ctype\n";
            // Собираем RGB-составляющие
            rgb_colors[ctype].val[0] += img.at<Vec3b>(x, y)[0];//CV_PIXEL(uchar, img, x, y)[0]; // B
            rgb_colors[ctype].val[1] += img.at<Vec3b>(x, y)[1];//CV_PIXEL(uchar, img, x, y)[1]; // G
            rgb_colors[ctype].val[2] += img.at<Vec3b>(x, y)[2];//CV_PIXEL(uchar, img, x, y)[2]; // R

            // Сохраняем, к какому типу относится цвет
            //color_indexes.at<Vec3b>(x, y)[0] = ctype;
            CV_PIXEL(uchar, color_indexes, x, y)[0] = ctype;

            // Подсчитываем
            colorCount[ctype]++;
        }
    }



    // Усредняем RGB-составляющие
    for (int i = 0; i < NUM_COLOR_TYPES; ++i){
        rgb_colors[i].val[0] /= colorCount[i];
        rgb_colors[i].val[1] /= colorCount[i];
        rgb_colors[i].val[2] /= colorCount[i];
    }

    // Загоним в вектор и отсортируем
    std::vector< std::pair< int, uint > > colors;
    colors.reserve(NUM_COLOR_TYPES);

    for (int i = 0; i < NUM_COLOR_TYPES; ++i){
        std::pair< int, uint > color;
        color.first = i;
        color.second = colorCount[i];
        colors.push_back( color );
    }

    // сортируем
    std::sort( colors.begin(), colors.end(), colors_comparation );

    // для отладки - выводим коды, названия цветов и их количество
    for (int i = 0; i < colors.size(); i++){
        printf("[i] color %d (%s) - %d\n", colors[i].first, sCTypes[colors[i].first], colors[i].second );
    }

    // выдаём код первых цветов
    printf("[i] color code: \n");
    for (int i = 0; i < NUM_COLOR_TYPES; ++i)
            printf("%02d ", colors[i].first);
    printf("\n");
    printf("[i] color names: \n");
    for (int i = 0; i < NUM_COLOR_TYPES; ++i)
            printf("%s ", sCTypes[colors[i].first]);
    printf("\n");


    if (DisplayOrNot)
    {
            // покажем цвета
        cvZero(dst2);
        int h = dst2->height / RECT_COLORS_SIZE;
        int w = dst2->width;
        for (int i=0; i<RECT_COLORS_SIZE; i++ ){
                cvRectangle(dst2, cvPoint(0, i*h), cvPoint(w, i*h+h), rgb_colors[colors[i].first], -1);
        }
        namedWindow("colors");
        cvShowImage("colors", dst2);
        waitKey(0);
        destroyWindow("colors");
        //cvShowImage("colors", dst2);
    }


    //cvSaveImage("dominate_colors_table.png", dst2);

    // покажем картинку в найденных цветах
    /*dst3 = cvCloneImage(image);
    for (y=0; y<dst3->height; y++) {
            for (x=0; x<dst3->width; x++) {
                    int color_index = CV_PIXEL(uchar, color_indexes, x, y)[0];

                    CV_PIXEL(uchar, dst3, x, y)[0] = rgb_colors[color_index].val[0];
                    CV_PIXEL(uchar, dst3, x, y)[1] = rgb_colors[color_index].val[1];
                    CV_PIXEL(uchar, dst3, x, y)[2] = rgb_colors[color_index].val[2];
            }
    }

    cvNamedWindow("dst3");
    cvShowImage("dst3", dst3);
    //cvSaveImage("dominate_colors.png", dst3);

    // конвертируем отладочную картинку обратно в RGB
    cvCvtColor( dst, dst, CV_HSV2BGR );

    // показываем результат
    cvNamedWindow("color");
    cvShowImage("color", dst);*/

    // ждём нажатия клавиши
    cvWaitKey(0);

    // освобождаем ресурсы
    //cvReleaseImage(&image);

    cvReleaseImage(&hsv);
    cvReleaseImage(&dst);
    cvReleaseImage(&dst2);
    cvReleaseImage(&color_indexes);
    cvReleaseImage(&dst3);
}

// ---------------------------------------------------------------------------------------

//
// определение преобладающих цветов на изображении
// при помощи k-Means
//

const CvScalar BLACK = CV_RGB(0, 0, 0);                         // чёрный
const CvScalar WHITE = CV_RGB(255, 255, 255);           // белый

const CvScalar RED        = CV_RGB(255, 0, 0);                         // красный
const CvScalar ORANGE     = CV_RGB(255, 100, 0);            // оранжевый
const CvScalar YELLOW     = CV_RGB(255, 255, 0);            // жёлтый
const CvScalar GREEN      = CV_RGB(0, 255, 0);                       // зелёный
const CvScalar LIGHTBLUE  = CV_RGB(60, 170, 255);        // голубой
const CvScalar BLUE       = CV_RGB(0, 0, 255);                        // синий
const CvScalar VIOLET     = CV_RGB(194, 0, 255);            // фиолетовый

const CvScalar GINGER     = CV_RGB(215, 125, 49);           // рыжий
const CvScalar PINK       = CV_RGB(255, 192, 203);            // розовый
const CvScalar LIGHTGREEN = CV_RGB(153, 255, 153);      // салатовый
const CvScalar BROWN      = CV_RGB(150, 75, 0);                      // коричневый

typedef struct ColorCluster {
    CvScalar color;
    CvScalar new_color;
    int count;

    ColorCluster(): count(0) {
    }
} ColorCluster;

float rgb_euclidean(CvScalar p1, CvScalar p2)
{
        float val = sqrtf( (p1.val[0]-p2.val[0])*(p1.val[0]-p2.val[0]) +
                (p1.val[1]-p2.val[1])*(p1.val[1]-p2.val[1]) +
                (p1.val[2]-p2.val[2])*(p1.val[2]-p2.val[2]) +
                (p1.val[3]-p2.val[3])*(p1.val[3]-p2.val[3]));

        return val;
}

// сортировка цветов по количеству
bool colors_sort(std::pair< int, uint > a, std::pair< int, uint > b)
{
        return (a.second > b.second);
}

void DetectFooty_method2(Mat img, bool &resultpaste, bool DisplayOrNot = false)
{
        // для хранения изображения
        IplImage *src=0, *dst=0, *dst2=0;

        // ресайзим картинку (для скорости обработки)
        src = cvCreateImage(cvSize(img.size().width/2, img.size().height/2), IPL_DEPTH_8U, 3);
        IplImage tmp = img;
        cvResize(&tmp, src, CV_INTER_LINEAR);

        //cvNamedWindow("img");
        //cvShowImage("img", src);

        // картинка для хранения индексов кластеров
        IplImage* cluster_indexes = cvCreateImage(cvGetSize(src), IPL_DEPTH_8U, 1);
        cvZero(cluster_indexes);

#define CLUSTER_COUNT 10
        int cluster_count = CLUSTER_COUNT;
        ColorCluster clusters[CLUSTER_COUNT];

        int i=0, j=0, k=0, x=0, y=0;

        // начальные цвета кластеров
#if 0
        clusters[0].new_color = RED;
        clusters[1].new_color = ORANGE;
        clusters[2].new_color = YELLOW;
        //      clusters[3].new_color = GREEN;
        //      clusters[4].new_color = LIGHTBLUE;
        //      clusters[5].new_color = BLUE;
        //      clusters[6].new_color = VIOLET;
#elif 0
        clusters[0].new_color = BLACK;
        clusters[1].new_color = GREEN;
        clusters[2].new_color = WHITE;
#else
        CvRNG rng = cvRNG(-1);
        for(k=0; k<cluster_count; k++)
                clusters[k].new_color = CV_RGB(cvRandInt(&rng)%255, cvRandInt(&rng)%255, cvRandInt(&rng)%255);
#endif

        // k-means
        float min_rgb_euclidean = 0, old_rgb_euclidean=0;

        while(1) {
                for(k=0; k<cluster_count; k++) {
                        clusters[k].count = 0;
                        clusters[k].color = clusters[k].new_color;
                        clusters[k].new_color = cvScalarAll(0);
                }

                for (y=0; y<src->height; y++) {
                        for (x=0; x<src->width; x++) {
                                // получаем RGB-компоненты пикселя
                                uchar B = CV_PIXEL(uchar, src, x, y)[0];        // B
                                uchar G = CV_PIXEL(uchar, src, x, y)[1];        // G
                                uchar R = CV_PIXEL(uchar, src, x, y)[2];        // R

                                min_rgb_euclidean = 255*255*255;
                                int cluster_index = -1;
                                for(k=0; k<cluster_count; k++) {
                                        float euclid = rgb_euclidean(cvScalar(B, G, R, 0), clusters[k].color);
                                        if(  euclid < min_rgb_euclidean ) {
                                                min_rgb_euclidean = euclid;
                                                cluster_index = k;
                                        }
                                }
                                // устанавливаем индекс кластера
                                CV_PIXEL(uchar, cluster_indexes, x, y)[0] = cluster_index;

                                clusters[cluster_index].count++;
                                clusters[cluster_index].new_color.val[0] += B;
                                clusters[cluster_index].new_color.val[1] += G;
                                clusters[cluster_index].new_color.val[2] += R;
                        }
                }

                min_rgb_euclidean = 0;
                for(k=0; k<cluster_count; k++) {
                        // new color
                        clusters[k].new_color.val[0] /= clusters[k].count;
                        clusters[k].new_color.val[1] /= clusters[k].count;
                        clusters[k].new_color.val[2] /= clusters[k].count;
                        float ecli = rgb_euclidean(clusters[k].new_color, clusters[k].color);
                        if(ecli > min_rgb_euclidean)
                                min_rgb_euclidean = ecli;
                }

                //printf("%f\n", min_rgb_euclidean);
                if( fabs(min_rgb_euclidean - old_rgb_euclidean)<1 )
                        break;

                old_rgb_euclidean = min_rgb_euclidean;
        }
        //-----------------------------------------------------

        // теперь загоним массив в вектор и отсортируем :)
        std::vector< std::pair< int, uint > > colors;
        colors.reserve(CLUSTER_COUNT);

        int colors_count = 0;
        for(i=0; i<CLUSTER_COUNT; i++){
                std::pair< int, uint > color;
                color.first = i;
                color.second = clusters[i].count;
                colors.push_back( color );
                if(clusters[i].count>0)
                        colors_count++;
        }
        // сортируем
        std::sort( colors.begin(), colors.end(), colors_sort );

        // покажем цвета
        dst2 = cvCreateImage( cvGetSize(src), IPL_DEPTH_8U, 3 );
        cvZero(dst2);
        int h = dst2->height / CLUSTER_COUNT;
        int w = dst2->width;
        for(i=0; i<CLUSTER_COUNT; i++ ){
                cvRectangle(dst2, cvPoint(0, i*h), cvPoint(w, i*h+h), clusters[colors[i].first].color, -1);
                printf("[i] Color: %d %d %d (%d)\n", (int)clusters[colors[i].first].color.val[2],
                        (int)clusters[colors[i].first].color.val[1],
                        (int)clusters[colors[i].first].color.val[0],
                        clusters[colors[i].first].count);
        }
        cvNamedWindow("colors");
        cvShowImage("colors", dst2);
        //cvResize(dst2, image, CV_INTER_LINEAR);
        //cvSaveImage("dominate_colors_table.png", image);
        //-----------------------------------------------------

        // покажем картинку в найденных цветах
        dst = cvCloneImage(src);
        for (y=0; y<dst->height; y++) {
                for (x=0; x<dst->width; x++) {
                        int cluster_index = CV_PIXEL(uchar, cluster_indexes, x, y)[0];

                        CV_PIXEL(uchar, dst, x, y)[0] = clusters[cluster_index].color.val[0];
                        CV_PIXEL(uchar, dst, x, y)[1] = clusters[cluster_index].color.val[1];
                        CV_PIXEL(uchar, dst, x, y)[2] = clusters[cluster_index].color.val[2];
                }
        }

        cvNamedWindow("dst");
        cvShowImage("dst", dst);
        //cvResize(dst, image, CV_INTER_LINEAR);
        //cvSaveImage("dominate_colors.png", image);
        //-----------------------------------------------------

        // ждём нажатия клавиши
        cvWaitKey(0);

        // освобождаем ресурсы
        //cvReleaseImage(&img);
        cvReleaseImage(&src);

        cvReleaseImage(&cluster_indexes);

        cvReleaseImage(&dst);
        cvReleaseImage(&dst2);

        // удаляем окна
        cvDestroyAllWindows();
        //return 0;
}



#endif // FOOTYDETECTOR_HPP_INCLUDED
