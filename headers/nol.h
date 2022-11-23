#ifndef JI_NOL
#define JI_NOL

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdarg.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/stat.h>

typedef enum method
{
    GET,
    POST,
    PUT,
    DELETE,
} method;

typedef struct request request;
struct request
{
    method m;
    const char *url;
    request *(*create)(const char *url, method m);
};

typedef struct response response;
struct response
{
    int (*status)(void);
    bool (*ok)(void);
    response *(*redirect)(const char *url, const char *message);
};

typedef struct html html;
struct html
{
    const char *layout;
    const char *view;
    response *(*render)(void);
};

typedef struct scss scss;
struct scss
{
    const char *filename;
    scss *(*design)(const char *element, const char *style);
};

typedef struct db db;
struct db
{
    const char *name;
    const char *table;
    char *sql;
    char *error;
};

typedef struct js js;
struct js
{
    const char *filename;
};

typedef struct form form;
struct form
{
    method m;
};

typedef struct nol nol;
struct nol
{
    const char *element;
    const char *id;
    html *html;
    scss *scss;
    js *js;
    form *form;
    request *request;
    response *response;
};

/**
 *
 * @brief Generate a request
 *
 * @param url           The request url
 * @param m             The request method
 *
 * @return request*
 *
 */
request *create(const char *url, method m);

/**
 *
 * @brief Render a view in a response
 *
 * @return response*
 *
 */
response *render(void);

/**
 *
 * @brief Redirect an user to an url
 *
 * @param url           The url to redirect
 * @param message       The flash message
 *
 * @return response*
 *
 */
response *redirect(const char *url, const char *message);

/**
 *
 * @brief Get the response status
 *
 * @return int The status code
 *
 */
int status(void);

/**
 *
 * @brief Check if the status code is a equal to 200
 *
 * @return true     Response is a success
 * @return false    Response is a redirect or a fail
 *
 */
bool ok(void);

/**
 *
 * @brief Add a scss rule to an element
 *
 * @param element   The element to style
 * @param style     The scss design code
 *
 * @return scss*
 */
scss *design(const char *element, const char *style);

nol *ji(void);

/**
 *
 * @brief Report a message
 *
 * @param format    The format to print
 * @param params    The format parameters
 *
 */
void report(const char *format, va_list params);

/**
 *
 * @brief print a message and exit the program (failure)
 *
 * @param format The format to print
 * @param ...  The format parameters
 */
void die(const char *format, ...);

extern html h;
extern scss s;
extern js j;
extern form f;
extern request req;
extern response res;
extern nol n;

#endif
