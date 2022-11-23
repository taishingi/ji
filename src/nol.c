#include "../headers/nol.h"

html h;
scss s;
js j;
form f;
request req;
response res;
nol n = {
    .html = &h,
    .scss = &s,
    .js = &j,
    .form = &f,
    .request = &req,
    .response = &res,
};

nol *ji(void)
{
    return &n;
}
void report(const char *format, va_list params)
{
    vfprintf(stderr, format, params);
}

void die(const char *format, ...)
{
    va_list msg;
    va_start(msg, format);
    report(format, msg);
    va_end(msg);
    exit(EXIT_FAILURE);
}
