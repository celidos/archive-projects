// Технические инклуды

#include <GL/gl.h>
#include <GL/glut.h>
#include <stdio.h>
#include <math.h>
#include <string>
#include <list>

// Инклуды по проекту

#include "droid.h"
#include "versions.h"
#include "spot.h"

GLfloat	 lightPos[]     = { 0.0f, 10.0f, 0.0f, 1.0f }; // Освещение
GLfloat  specular[]     = { 1.0f, 1.0f,  1.0f, 1.0f };
GLfloat  specref[]      = { 1.0f, 1.0f,  1.0f, 1.0f };
GLfloat  ambientLight[] = { 0.5f, 0.5f,  0.5f, 1.0f };
GLfloat  fBrightLight[] = { 1.0f, 1.0f,  1.0f, 1.0f };

// Игровые объекты
Droid droid;
FlySpotLight spot;
GameWorld challenge1;

// Обработка движений мыши
int lastx = 0, lasty = 0;
int mousedown = 0;

// Настраиваемые параметры

       bool dbAutoPrintPos      = false;
       bool dbAutoIntersect     = false;
       bool dbShootingAllowed   = true;
       bool dbAutoWallDistances = false;
       bool dbAutoSpeed         = false;
       bool dbAutoBullets       = true;
       bool dbAutoPrintTurn     = false;
extern float brakespeed;
extern float max_v;
extern float max_v2;
extern float move_speed;
extern const float basesize;
extern const float Rsize;
       int  TimerDelay          = 40;
       float MouseSensetive     = 0.04;

       int HalfWindowWidth          = 400;
       int HalfWindowHeight         = 300;
//
//

void gameconsole()
{
    bool letsexit = false;
    char s_arr[255];
    string s;
    while (!letsexit)
    {
        printf ("> ");
        scanf("%255s", s_arr);
        //fgets(s_arr, 255, stdin);
        string s = s_arr;
        if (s == "delay")
        {
            int newdelay;
            scanf("%ud", &newdelay);
            if (newdelay > 8196)
                newdelay = 8196;
            if (newdelay < 5)
                newdelay = 5;
            TimerDelay = newdelay;
            printf (" [ok]\n");
        }
        else if (s == "a")
        {
            scanf("%255s", s_arr);
            s = s_arr;
            if (s == "pos")
            {
                dbAutoPrintPos = !dbAutoPrintPos;
                printf ("[dbAutoPrintPos = %i]\n", dbAutoPrintPos);
            }
            else if (s == "inter")
            {
                dbAutoIntersect = !dbAutoIntersect;
                printf ("[dbAutoIntersect = %i]\n", dbAutoIntersect);
            }
            else if (s == "walldist")
            {
                dbAutoWallDistances = !dbAutoWallDistances;
                printf ("[dbAutoWallDistances = %i]\n", dbAutoWallDistances);
            }
            else if (s == "speed")
            {
                dbAutoSpeed = !dbAutoSpeed;
                printf ("[dbAutoSpeed = %i]\n", dbAutoSpeed);
            }
            else if (s == "bullets")
            {
                dbAutoBullets = !dbAutoBullets;
                printf("[dbAutoBullets = %i]\n", dbAutoBullets);
            }
            else if (s == "turn")
            {
                dbAutoPrintTurn = !dbAutoPrintTurn;
                printf("[dbAutoPrintTurn = %i]\n", dbAutoPrintTurn);
            }
        }
        else if (s == "cbs")
        {
            challenge1.bullets.clear();
            printf ("[bullstack cleaned]\n", dbAutoWallDistances);
        }
        else if (s == "shot")
        {
            int temp;
            scanf("%d", &temp);
            dbShootingAllowed = temp;
            printf ("[dbShootingAllowed = %i]\n", dbShootingAllowed);
        }
        else if (s == "home")
        {
            droid.pos.form(0, 0, 0);
            droid.v.form(0, 0, 0);
        }
        else if (s == "speed-")
        {
            float newslow;
            scanf("%f", &newslow);
            if (newslow < 1e-5)
                newslow = 0.0f;
            brakespeed = newslow;
            printf ("[brakespeed = %.3f]\n", brakespeed);
        }
        else if (s == "maxv")
        {
            float newv;
            scanf("%f", &newv);
            if (newv < 1e-5)
                newv = 0.0f;
            max_v = newv;
            max_v2 = max_v * max_v;
            printf ("[maxv = %.3f]\n", max_v);
        }
        else if (s == "speed+")
        {
            float newv;
            scanf("%f", &newv);
            if (newv < 1e-5)
                newv = 0.0f;
            move_speed = newv;
            printf ("[move_speed = %.3f]\n", move_speed);
        }
        else
            letsexit = true;
    }
    printf("! Continue...\n");
}

void ProcessMenu(int value)
{
    //glutPostRedisplay();
}

void RenderScene()
{
    glShadeModel(GL_SMOOTH); // установка параметров
    glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); // Очищаем буфер глубины и цвета
    glLightfv(GL_LIGHT0, GL_POSITION, lightPos);

    droid.Draw(); // Сначала рисуем дроида

    glPushMatrix();

        droid.TransformAllTheWorld(); // Сдвигаем систему координат

        spot.Draw(); // Подвижный источник света

        DrawWorldAxises(10.0f); // Нарисуем оси мира
        DrawChessPlate();
        DrawSomeTeapots();

        challenge1.Draw();

    glPopMatrix();

    glutSwapBuffers();
}

void SetupRC()
{
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f );

    glCullFace(GL_BACK);
    glEnable(GL_DEPTH_TEST);	// Удаляет спрятанные грани
    glFrontFace(GL_CCW);		// Полионы напрвлены наружу
    //glEnable(GL_CULL_FACE);	// Не пытаться рисовать задние грани

    glEnable(GL_LIGHTING);   // Включаем освещение


    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, ambientLight);

    glLightfv(GL_LIGHT0, GL_DIFFUSE, ambientLight);
    glLightfv(GL_LIGHT0, GL_SPECULAR, specular);
    glLightfv(GL_LIGHT0, GL_POSITION, lightPos);

    glLightfv(GL_LIGHT1, GL_DIFFUSE, ambientLight);
    glLightfv(GL_LIGHT1, GL_SPECULAR, specular);
    glLightfv(GL_LIGHT1, GL_POSITION, spot.lightPos);

    glLightf(GL_LIGHT1, GL_SPOT_CUTOFF, 50.0f);


    ///glEnable(GL_LIGHT0); // Глобальное освещение
    glEnable(GL_LIGHT1); // для FlySpotLight

    glEnable(GL_COLOR_MATERIAL); // Включить свойства поверхности
    glColorMaterial(GL_FRONT, GL_AMBIENT_AND_DIFFUSE); // Свет соостветсвует цвету поверхности

    glMaterialfv(GL_FRONT, GL_SPECULAR, specref);
    glMateriali(GL_FRONT, GL_SHININESS, 96);

    glShadeModel(GL_SMOOTH);

    rvector p, t;
    p.form(0.0f, 0.0f, 0.0f);
    t.form(1.0f, 0.0f, 0.0f);

    droid = Droid(p, t, &challenge1);
    spot = FlySpotLight(-5, 0, 0, 270);

    /*float ch1[3][12]
    {
    {-10, 10, 10, -10, 20, 10,-20, 10, 10,   1, 1, 1},
    {-10, 10, 10,  -20, 10, 10, -10, 10, 20,0.7, 0.2, 0.5},
    {-10, 10, 10,  -10, 10, 20, -10, 20, 10,0.3, 0.99, 0.1}
    };*/
    const int testN = 100;
    float ch1[testN][12];
    for (int j = 0; j < testN; ++j)
    {
        ch1[j][0] = -5.0 * j;
        ch1[j][1] = 10;
        ch1[j][2] = 10;

        ch1[j][3] = ch1[j][0];
        ch1[j][4] = 10;
        ch1[j][5] = 20;

        ch1[j][6] = ch1[j][0];
        ch1[j][7] = 20;
        ch1[j][8] = 10;

        ch1[j][9] = 0.3;
        ch1[j][10] = 0.99;
        ch1[j][11] = 0.1;
    }
    challenge1.ScanWallsFromFloat12Array(testN, ch1);
    //printf("%f %f %f\n", challenge1.walls[1].v[2][0], challenge1.walls[1].v[2][1], challenge1.walls[1].v[2][2]);
    RenderScene();
}

void SpecialKeys(int key, int x, int y)
{
    const float speed = 5;

    if(key == GLUT_KEY_LEFT)
        droid.turn[1] -= speed;
    else if (key == GLUT_KEY_RIGHT)
        droid.turn[1] += speed;

    To360degrees(droid.turn[0]);
    To360degrees(droid.turn[1]);

    if (key == GLUT_KEY_PAGE_UP || key == GLUT_KEY_UP)
        droid.GetMove(false);
    else if (key == GLUT_KEY_PAGE_DOWN || key == GLUT_KEY_DOWN)
        droid.GetMove(true);
    else if (key == GLUT_KEY_F1)
        gameconsole();
    else if (key == GLUT_KEY_F4)
        exit(0);
}

void KeyWindow(unsigned char key, int x, int y)
{
    const float speed = 0.4;
    if(key == 'a')
        spot.lightPos[0] -= speed;
    else if(key == 'd')
        spot.lightPos[0] += speed;

    if(key == 'w')
        spot.lightPos[1] += speed;
    else if(key == 's')
        spot.lightPos[1] -= speed;

    if(key == 'z')
        spot.lightPos[2] -= speed;
    else if(key == 'c')
        spot.lightPos[2] += speed;

    if (key == 'r')
        spot.angle += 5;
    else if (key == 't')
        spot.angle -= 5;

    if (key == '=')
        droid.H_angle += 5;
    else if (key == '-')
        droid.H_angle -= 5;

    To360degrees(spot.angle);
    To360degrees(droid.H_angle);

    if (key == 'p')
    {
        printf("*** Info :\n");
        printf("] Speed    : (%.2f; %.2f; %.2f)\n", droid.v[0], droid.v[1], droid.v[2]);
        printf("] Position : (%.2f; %.2f; %.2f)\n", droid.pos[0], droid.pos[1], droid.pos[2]);
        printf("\nOther info:\n\n");
        printf("] bullets now : %i\n", challenge1.bullets.size());

        printf("___\n\n");
    }
    if (key == 'm')
        droid.SuperMultiShoot();
}

void TimerFunction(int value)
{
    droid.rot_angle -= 4;
    To360degrees(droid.rot_angle);

    droid.Refresh_mechanic();
    challenge1.Refresh_mechanic(droid.pos);

    glutPostRedisplay();
    glutTimerFunc(TimerDelay, TimerFunction, 1); //glutTimerFunc(40, TimerFunction, 1);

    if (dbAutoPrintPos)
        printf("] Position : (%.2f; %.2f; %.2f)\n", droid.pos[0],  droid.pos[1],  droid.pos[2]);
    if (dbAutoSpeed)
        printf("] Speed    : (%.2f; %.2f; %.2f)\n", droid.v[0],    droid.v[1],    droid.v[2]);
    if (dbAutoPrintTurn)
        printf("] Turn     : (%.2f; %.2f; %.2f)\n", droid.turn[0], droid.turn[1], droid.turn[2]);

    if (mousedown)
    {
        if (!dbShootingAllowed)
        {
            printf ("! Shooting is not allowed!\n");
            return;
        }
        droid.Shoot(mousedown - 1);
    }
}

void ChangeSize(int w, int h)
{
    GLfloat fAspect;

    if (h == 0) h = 1; // Предоствращает деление на ноль

    glViewport(0, 0, w, h); // Задает поле зрения

    glMatrixMode(GL_PROJECTION); // переустанавливает систему координат
    glLoadIdentity();

    fAspect = (GLfloat) w / (GLfloat) h; // Устанавливаем расстояние от камеры до экрана
    gluPerspective(35.0f, fAspect, 1.0f, 400.0f);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glTranslatef(0.0f, 0.0f, -20.0f);
}

void MotionPas (int x, int y)
{
    float xspeed = (x - HalfWindowWidth ) * MouseSensetive,
          yspeed = (y - HalfWindowHeight) * MouseSensetive;

    droid.turn[0] += yspeed;
    droid.turn[1] += xspeed;

    if (x != HalfWindowWidth || y != HalfWindowHeight)
        glutWarpPointer(HalfWindowWidth, HalfWindowHeight);
    To360degrees(droid.turn[0]);
    To360degrees(droid.turn[1]);
}

void MouseFunc(int button, int state, int x, int y)
{
    if ((button == GLUT_LEFT_BUTTON || button == GLUT_RIGHT_BUTTON) && state == GLUT_DOWN)
    {
        if (!dbShootingAllowed)
        {
            printf ("! Shooting is not allowed!\n");
            return;
        }
        mousedown = button + 1;
        droid.Shoot(button);
    }
    else if (state == GLUT_UP)
        mousedown = 0;
    else if (button == 3 && state == GLUT_DOWN)
    {
        droid.H_angle += 10;
        To360degrees(droid.H_angle);
    }
    else if (button == 4 && state == GLUT_DOWN)
    {
        droid.H_angle -= 10;
        To360degrees(droid.H_angle);
    }
}

// ========================================

int main(int argc, char* argv[])
{
    int nMenu;
    srand(time(NULL));

    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(2 * HalfWindowWidth, 2 * HalfWindowHeight);
    glutCreateWindow("Terra Fire 2");
    glutSetCursor(GLUT_CURSOR_NONE);
    glutReshapeFunc(ChangeSize);
    glutSpecialFunc(SpecialKeys);
    glutKeyboardFunc(KeyWindow);
    glutDisplayFunc(RenderScene);
    glutPassiveMotionFunc(MotionPas);
    glutMotionFunc(MotionPas);
    glutMouseFunc(MouseFunc);
    SetupRC();
    glutTimerFunc(50, TimerFunction, 1);
    glutMainLoop();

    return 0;
}
