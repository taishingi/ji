/**
 * @file zuu.c
 * @author taishingi (micieli@vivaldi.net)
 * @brief Compiler source code
 * @version 0.1
 * @date 2022-11-22
 *
 * @copyright Copyright (c) 2022
 *
 */
#include "../headers/zuu.h"

bool has(const char *argv, const char *expected)
{
    return strstr(argv, expected) != NULL;
}

bool arg(const char *argv, const char *expected)
{
    return strcmp(argv, expected) == EXIT_SUCCESS;
}

bool file_exists(const char *filename)
{
    if (access(filename, F_OK) == EXIT_SUCCESS)
    {
        return true;
    }
    die(MISSING_PROGRAM_SOURCE_CODE, filename);
}

bool parse(const char *filename)
{
    int c;
    FILE *f = fopen(filename, "r");
    if (f)
    {
        while (!feof(f))
        {
            c = fgetc(f);
            fputc(c, stdout);
        }
        return fclose(f) == EXIT_SUCCESS;
    }
    fclose(f);
    die("Failed to open the %s program filename", filename);
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
