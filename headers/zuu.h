/**
 * @file zuu.h
 * @author taishingi (micieli@vivaldi.net)
 * @brief Compiler library
 * @version 0.1
 * @date 2022-11-22
 *
 * @copyright Copyright (c) 2022
 *
 */

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

#define COMPILE_FILE_TITLE "\033[1;37m[\033[1;32m COMPILING \033[1;37m] \033[1;34m%s\033[30m\n"
#define MISSING_PROGRAM_SOURCE_CODE "\033[1;37m[\033[1;5;31m MISSING \033[1;0;37m] \033[1;34m%s\033[30m\n"
/**
 *
 * @brief Check if a parameter has been founded
 *
 * @param argv          The actual value
 * @param expected      The expected value
 *
 * @return true         The expected parameter has been founded
 * @return false        The expected parameter has not been found
 *
 */
bool arg(const char *argv, const char *expected);

/**
 *
 * @brief Check if the argv contains expected
 *
 * @param argv          The actual value
 * @param expected      The expected value
 *
 * @return true         The expected value has been founded
 * @return false        The expected value has not been founded
 *
 */
bool has(const char *argv, const char *expected);

/**
 *
 * @brief parse a file
 *
 * @param filename The filename
 *
 * @return true     The parser has been a success
 * @return false    The parser has failed
 *
 */
bool parse(const char *filename);

/**
 *
 * @brief Report a message
 *
 * @param format    The message format
 * @param params    The message arguments
 *
 */
void report(const char *format, va_list params);

/**
 *
 * @brief Print a message and exit the program
 *
 * @param format    The message format
 * @param ...       The message args
 *
 */
void die(const char *format, ...);

/**
 *
 * @brief Check if a file already exist on the system
 *
 * @param filename  The filename
 *
 * @return true         The file has been founded
 * @return false        The file has not been found
 *
 */
bool file_exists(const char *filename);


#endif