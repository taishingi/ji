#include "../headers/nol.h"

html h;
scss s;
js j;
form f = {
    .add = &add,
};
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

form *add(const char *type,const char *name,const char *classes,const char *id,const char *placeholder,const char *event,const char *callback)
{
    char i[FILENAME_MAX];
    snprintf(i,FILENAME_MAX,"<input type=\"%s\" name=\"%s\" class=\"%s\" id=\"%s\" placeholder=\"%s\"  on%s=\"%s()\" ></type>",type,name,classes,id,placeholder,event,callback);
    strcat(f.data,i);
    return &f;
}

