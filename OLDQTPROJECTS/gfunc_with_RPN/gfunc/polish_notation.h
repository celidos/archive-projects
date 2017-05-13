#ifndef POLISH_NOTATION_H_INCLUDED
#define POLISH_NOTATION_H_INCLUDED

#include <string>
#include <vector>
#include <stack>
#include <cstdio>
#include <cmath>
#include <iostream>

#define RPN_X    0
#define RPN_NUM  1
#define RPN_PI   2
#define RPN_E    3
#define RPN_SQRT 4
#define RPN_LN   5
#define RPN_EXP  6
#define RPN_SIN  7
#define RPN_COS  8
#define RPN_TG   9
#define RPN_CTG 10

#define OPERATION_IS_FUNCTION 20

#define RPN_UNDEFINED_FUNCTION -1

#define DELTA_ZERO 1e-30

using namespace std;

struct rpn_stack_elem
{
    char op;
    float x;
    bool rpriority;
};

bool is_operation(char t);

int get_priority(char op);

bool is_rop(char op);

bool is_uno(char op);

bool is_number(char t);

bool is_letter(char t);

bool more(char op1, char op2);

bool moreq(char op1, char op2);

bool hasFractionalPart(float val);

float quick_power(float x, int n);

float read_float_from_pos(string &s, int pos, int &nextpos);

int read_function_name_from_pos(string &s, int pos, int &nextpos);

void print_rpn_stack(stack <rpn_stack_elem> ST);

bool get_rpn(string req, stack <rpn_stack_elem> &outres);

float rpn_count(stack <rpn_stack_elem> rpn, float x, bool &ok);

#endif // POLISH_NOTATION_H_INCLUDED
