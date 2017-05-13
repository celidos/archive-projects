#ifndef COMPLEX_HPP
#define COMPLEX_HPP

#include <cmath>

typedef long double ld;

inline ld qw(ld x) { return x*x; }

struct Complex
{
    ld x;
    ld y;
    void set(ld X, ld Y)
    {
        this->x = X;
        this->y = Y;
    }
    Complex()
    {

    }

    Complex(ld X, ld Y)
    {
        this->x = X;
        this->y = Y;
    }
    Complex operator= (const Complex &b) {
        this->x = b.x;
        this->y = b.y;
        return *this;
    }

    const Complex operator+ (const Complex &b) const {
        return Complex(this->x + b.x, this->y + b.y);
    }
    const Complex operator- (const Complex &b) const {
        return Complex(this->x - b.x, this->y - b.y);
    }
    const Complex operator* (const Complex &b) const {
        return Complex(this->x*b.x - this->y*b.y, this->x*b.y + this->y*b.x);
    }
    const Complex operator/ (const Complex &b) const {
        float d = (b.x)*(b.x) + (b.y)*(b.y);
        if (d == 0)
            return Complex(0, 0);
        d = 1/d;
        return Complex(((this->x*b.x + this->y*b.y)*d), ((b.x*this->y - this->x*b.y)*d));
    }
    const ld Abs2() const {
        return this->x*this->x + this->y*this->y;
    }
    const ld Abs() const {
        return sqrt(this->x*this->x + this->y*this->y);
    }
    const Complex operator^(unsigned int k) const // возведение t в степень k
    {
        Complex res = *this, t = *this;
        --k;
        while (k)
        {
            if (k & 1)
                res = res * t;
            res = res * res;
            k >>= 1;
        }
        return res;
    }
    const Complex getexp()
    {
        return Complex(exp(x) * cos(y), exp(y) * sin(y));
    }
};

#endif // COMPLEX_HPP
