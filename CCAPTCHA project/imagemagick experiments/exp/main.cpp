#include <Magick++.h>
#include <iostream>

using namespace std;
using namespace Magick;

int main( int argc, char **argv )
{
    InitializeMagick(*argv);

    /*Image oImage;
    oImage.read( "test.jpg" );
    oImage.zoom( Geometry("200x200") );
    oImage.read( "test_out.jpg" );*/
    return 0;
}
