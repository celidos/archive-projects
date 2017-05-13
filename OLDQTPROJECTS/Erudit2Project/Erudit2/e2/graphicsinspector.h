#ifndef GRAPHICSINSPECTOR_H
#define GRAPHICSINSPECTOR_H

#include <QImage>
#include <iostream>

class GraphicsInspector
{
public:
    QImage *image;
    const unsigned int imagescount = 50;

    void LoadGraphics(QString &path);
    QImage * Get(unsigned int index);
};

#endif // GRAPHICSINSPECTOR_H
