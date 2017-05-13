#include "polish_notation.h"

bool is_operation(char t)
{
    return (t == '^' ||
            t == '+' ||
            t == '-' ||
            t == '*' ||
            t == '/');
}

int get_priority(char op)
{
    if (op < OPERATION_IS_FUNCTION) return -1;
    if (op == '^' || op == '_')     return 0;
    if (op == '*' || op == '/')     return 1;
    if (op == '+' || op == '-')     return 2;
    if (op == '(' || op == ')')     return 3;
}

bool is_rop(char op)
{
    return (op == '^' || op == '_');
}

bool is_uno(char op)
{
    return (op == '_' || op < OPERATION_IS_FUNCTION);
}

bool is_number(char t)
{
    return (t >= '0' && t <= '9');
}

bool is_letter(char t)
{
    return (t >= 'a' && t <= 'z');
}

bool more(char op1, char op2)
{
    return (get_priority(op1) < get_priority(op2));
}

bool moreq(char op1, char op2)
{
    return (get_priority(op1) <= get_priority(op2));
}

bool hasFractionalPart(float val){
    return val - floor(val) > 0 ;
}

float quick_power(float x, int n)
{
    float ans = 1.0;
    while (n > 0)
    {
        if (n%2==1) ans*=x;
        x*=x;
        n>>=1;
    }
    return ans;
}

float read_float_from_pos(string &s, int pos, int &nextpos)
{
    bool waspoint = false;
    float r1 = 0, r2 = 0, d = 10;
    for (int i = pos; i < (int)s.length(); ++i)
    {
        if (s[i] == '.' || s[i] == ',')
            waspoint = true;
        else if (is_number(s[i]))
        {
            float c = (float)(s[i] - '0');
            if (!waspoint)
            {
                r1 = r1 * 10 + c;
            }
            else
            {
                r2 += c / d;
                d *= 10;
            }
        }
        else
        {
            nextpos = i;
            return r1 + r2;
        }
    }
}

int read_function_name_from_pos(string &s, int pos, int &nextpos)
{
    int i;
    for (i = pos; i < (int)s.length(); ++i)
        if (!is_letter(s[i]))
            break;
    string f_name = s.substr(pos, i - pos);
    nextpos = pos + (int)f_name.size();
    if (f_name == "sqrt") return RPN_SQRT;
    if (f_name == "ln")   return RPN_LN;
    if (f_name == "exp")  return RPN_EXP;
    if (f_name == "sin")  return RPN_SIN;
    if (f_name == "cos")  return RPN_SIN;
    if (f_name == "tg")   return RPN_TG;
    if (f_name == "ctg")  return RPN_CTG;
    return RPN_UNDEFINED_FUNCTION;
}

void print_rpn_stack(stack <rpn_stack_elem> ST)
{
    while (!ST.empty())
    {
        rpn_stack_elem el = ST.top();
        if (el.op == RPN_NUM)
            cout << el.x << " ";
        else if (el.op == RPN_X)
            cout << "[x] ";
        else if (el.op == RPN_PI)
            cout << "π ";
        else if (el.op == RPN_SQRT)
            cout << "<√> ";
        else if (el.op == RPN_LN)
            cout << "<ln> ";
        else if (el.op == RPN_EXP)
            cout << "<exp> ";
        else if (el.op == RPN_SIN)
            cout << "<sin> ";
        else if (el.op == RPN_COS)
            cout << "<cos> ";
        else if (el.op == RPN_TG)
            cout << "<tg> ";
        else if (el.op == RPN_CTG)
            cout << "<ctg> ";
        else
            cout << el.op << " ";
        ST.pop();
    }
}

bool get_rpn(string req, stack <rpn_stack_elem> &outres)
{
    req = '(' + req + ')';
    stack <rpn_stack_elem> res;
    stack <char> st;
    int len = req.length();
    int i = 0;
    bool canbeuno = true;
    for (i = 0; i < len; ++i)
    {
        rpn_stack_elem el;
        if (req[i] == ' ') continue;
        else if (req[i] == '(')
        {
            st.push('(');
            canbeuno = true;
        }
        else if (is_number(req[i]))
        {
            int ni;
            el.op = RPN_NUM;
            el.x = read_float_from_pos(req, i, ni);
            res.push(el);

            i = ni - 1;
            canbeuno = false;
        }
        else if (req[i] == 'x')
        {
            el.op = RPN_X;
            res.push(el);
            canbeuno = false;
        }
        else if (req[i] == 'p' && i+1 < len && req[i+1] == 'i')
        {
            el.op = RPN_PI;
            res.push(el);
            ++i;
            canbeuno = false;
        }
        else if (is_operation(req[i]))
        {
            char op = req[i];
            if (req[i] == '-')
            {
                if (canbeuno)
                {
                    while (!st.empty())
                    {
                        if ( (!is_rop(st.top()) && moreq(st.top(), '_')) ||
                            (is_rop(st.top()) && more (st.top(), '_')))
                        {
                            el.op = st.top();
                            el.rpriority = is_rop(el.op);
                            res.push(el);
                            st.pop();
                        }
                        else break;
                    }
                    st.push('_');
                    continue;
                }
            }

            while (!st.empty())
            {
                if ( (!is_rop(st.top()) && moreq(st.top(), op)) ||
                      (is_rop(st.top()) && more (st.top(), op)))
                {
                    el.op = st.top();
                    el.rpriority = is_rop(el.op);
                    res.push(el);
                    st.pop();
                }
                else break;
            }
            st.push(op);
            canbeuno = true;
        }
        else if (req[i] == ')')
        {
            while (!st.empty())
            {
                if (st.top() != '(')
                {
                    el.op = st.top();
                    el.rpriority = is_rop(el.op);
                    res.push(el);
                    st.pop();
                }
                else
                {
                    st.pop();
                    break;
                }
            }
            canbeuno = false;
        }
        else // function
        {
            int ni;
            st.push(read_function_name_from_pos(req, i, ni));
            i = ni - 1;
            canbeuno = false;
            continue;
        }
    }
    while (!res.empty())
    {
        outres.push(res.top());
        res.pop();
    }
    return true;
}

float rpn_count(stack <rpn_stack_elem> rpn, float x, bool &ok)
{
    float ans = 0;
    stack <float> st;
    ok = true;
    while (!rpn.empty())
    {
        rpn_stack_elem el = rpn.top();

        if (el.op == RPN_NUM)
            st.push(el.x);
        else if (el.op == RPN_X)
            st.push(x);
        else if (el.op == RPN_PI)
            st.push(M_PI);
        else
        {
            char op = el.op;
            float o2 = st.top(), o1;
            st.pop();
            if (!is_uno(op))
            {
                o1 = st.top();
                st.pop();
            }

                 if (op == '+') st.push(o1 + o2);
            else if (op == '-') st.push(o1 - o2);
            else if (op == '*') st.push(o1 * o2);
            else if (op == '/')
            {
                if (fabs(o2) > DELTA_ZERO)
                    st.push(o1 / o2);
                else
                {
                    ok = false;
                    return NAN;
                }
            }
            else if (op == '^')
            {
                if (!hasFractionalPart(o2) && o2 > 0)
                    st.push(quick_power(o1, round(o2)));
                else if (o1 >= 0.0)
                    st.push(pow(o1, o2));
                else
                {
                    ok = false;
                    return NAN;
                }
            }
            else if (op == '_')
            {
                st.push(-o2);
            }
            else if (op == RPN_SQRT)
            {
                if (o2 >= 0) st.push(sqrt(o2));
                else
                {
                    st.push(NAN);
                    ok = false;
                }
            }
            else if (op == RPN_LN)
            {
                if (o2 > DELTA_ZERO) st.push(log(o2));
                else
                {
                    st.push(NAN);
                    ok = false;
                }
            }
            else if (op == RPN_EXP)
            {
                st.push(exp(o2));
            }
            else if (op == RPN_SIN)
                st.push(sin(o2));
            else if (op == RPN_COS)
                st.push(cos(o2));
            else if (op == RPN_TG)
                st.push(tan(o2));
            else if (op == RPN_CTG)
                st.push(1/tan(o2));
            else
            {
                cout << "Error : Undefined operation.\n";
                ok = false;
                return 0;
            }
        }
        rpn.pop();
    }

    if (!rpn.empty())
        ok = false;

    if (ok)
        return st.top();
    else
        return 0;
}

