/* Define a C preprocessor symbol that can be used in interface files
   to distinguish between the SWIG language modules. */

#define SWIG_RUBY_FFI

/* Typespecs for basic types. */

%typemap(cin) void ":void";

%typemap(cin) char ":char";
%typemap(cin) char * ":string";
%typemap(cin) unsigned char ":uchar";
%typemap(cin) signed char ":char";

%typemap(cin) short ":short";
%typemap(cin) signed short ":short";
%typemap(cin) unsigned short ":ushort";

%typemap(cin) int ":int";
%typemap(cin) signed int ":int";
%typemap(cin) unsigned int ":uint";

%typemap(cin) long ":long";
%typemap(cin) signed long ":long";
%typemap(cin) unsigned long ":ulong";

%typemap(cin) long long ":long_long";
%typemap(cin) signed long long ":long_long";
%typemap(cin) unsigned long long ":ulong_long";

%typemap(cin) float ":float";
%typemap(cin) double ":double";
%typemap(cin) SWIGTYPE ":pointer";

%typemap(cout) void ":void";

%typemap(cout) char ":char";
%typemap(cout) char * ":string";
%typemap(cout) unsigned char ":uchar";
%typemap(cout) signed char ":char";

%typemap(cout) short ":short";
%typemap(cout) signed short ":short";
%typemap(cout) unsigned short ":ushort";

%typemap(cout) int ":int";
%typemap(cout) signed int ":int";
%typemap(cout) unsigned int ":uint";

%typemap(cout) long ":long";
%typemap(cout) signed long ":long";
%typemap(cout) unsigned long ":ulong";

%typemap(cout) long long ":long_long";
%typemap(cout) signed long long ":long_long";
%typemap(cout) unsigned long long ":ulong_long";

%typemap(cout) float ":float";
%typemap(cout) double ":double";
%typemap(cout) SWIGTYPE ":pointer";


%typemap(ctype) bool                       "int";
%typemap(ctype) char, unsigned char, signed char,
                short, signed short, unsigned short,
                int, signed int, unsigned int,
                long, signed long, unsigned long,
                float, double, long double, char *, void *, void,
                enum SWIGTYPE, SWIGTYPE *,
                SWIGTYPE[ANY], SWIGTYPE &  "$1_ltype";
%typemap(ctype) SWIGTYPE                   "$&1_type";

%typemap(in) bool                          "$1 = (bool)$input;";
%typemap(in) char, unsigned char, signed char,
             short, signed short, unsigned short,
             int, signed int, unsigned int,
             long, signed long, unsigned long,
             float, double, long double, char *, void *, void,
             enum SWIGTYPE, SWIGTYPE *,
             SWIGTYPE[ANY], SWIGTYPE &     "$1 = $input;";
%typemap(in) SWIGTYPE                      "$1 = *$input;";

%typemap(out) void                         "";
%typemap(out) bool                          "$result = (int)$1;";
%typemap(out) char, unsigned char, signed char,
              short, signed short, unsigned short,
              int, signed int, unsigned int,
              long, signed long, unsigned long,
              float, double, long double, char *, void *,
              enum SWIGTYPE, SWIGTYPE *,
              SWIGTYPE[ANY], SWIGTYPE &    "$result = $1;";
#ifdef __cplusplus
%typemap(out) SWIGTYPE                     "$result = new $1_type($1);";
#else
%typemap(out) SWIGTYPE {
  $result = ($&1_ltype) malloc(sizeof($1_type));
  memmove($result, &$1, sizeof($1_type));
}
#endif

%typecheck(SWIG_TYPECHECK_BOOL) bool { $1 = 1; };
%typecheck(SWIG_TYPECHECK_CHAR) char { $1 = 1; };
%typecheck(SWIG_TYPECHECK_FLOAT) float { $1 = 1; };
%typecheck(SWIG_TYPECHECK_DOUBLE) double { $1 = 1; };
%typecheck(SWIG_TYPECHECK_STRING) char * { $1 = 1; };
%typecheck(SWIG_TYPECHECK_INTEGER)
                    unsigned char, signed char,
                    short, signed short, unsigned short,
                    int, signed int, unsigned int,
                    long, signed long, unsigned long,
                    enum SWIGTYPE { $1 = 1; };
%typecheck(SWIG_TYPECHECK_POINTER) SWIGTYPE *, SWIGTYPE &,
                                   SWIGTYPE[ANY], SWIGTYPE { $1 = 1; };
/* This maps C/C++ types to Lisp classes for overload dispatch */

%typemap(lisptype) bool "cl:boolean";
%typemap(lisptype) char "cl:character";
%typemap(lisptype) unsigned char "cl:integer";
%typemap(lisptype) signed char "cl:integer";

%typemap(lispclass) bool "t";
%typemap(lispclass) char "cl:character";
%typemap(lispclass) unsigned char, signed char,
                    short, signed short, unsigned short,
                    int, signed int, unsigned int,
                    long, signed long, unsigned long,
                    enum SWIGTYPE       "cl:integer";
/* CLOS methods can't be specialized on single-float or double-float */
%typemap(lispclass) float "cl:number";
%typemap(lispclass) double "cl:number";
%typemap(lispclass) char * "cl:string";


%{

#ifdef __cplusplus
#  define EXTERN   extern "C"
#else
#  define EXTERN   extern
#endif

#define EXPORT   EXTERN SWIGEXPORT

#include <string.h>
%}

%insert("swiglisp") %{
###SWIG wrapper code starts here

###SWIG wrapper code ends here
%}

#ifdef __cplusplus
%typemap(out) SWIGTYPE                     "$result = new $1_type($1);";
#else
%typemap(out) SWIGTYPE {
  $result = ($&1_ltype) malloc(sizeof($1_type));
  memmove($result, &$1, sizeof($1_type));
}
#endif

//////////////////////////////////////////////////////////////

/* name conversion for overloaded operators. */
#ifdef __cplusplus
%rename(__add__)	     *::operator+;
%rename(__pos__)	     *::operator+();
%rename(__pos__)	     *::operator+() const;

%rename(__sub__)	     *::operator-;
%rename(__neg__)	     *::operator-() const;
%rename(__neg__)	     *::operator-();

%rename(__mul__)	     *::operator*;
%rename(__deref__)	     *::operator*();
%rename(__deref__)	     *::operator*() const;

%rename(__div__)	     *::operator/;
%rename(__mod__)	     *::operator%;
%rename(__logxor__)	     *::operator^;
%rename(__logand__)	     *::operator&;
%rename(__logior__)	     *::operator|;
%rename(__lognot__)	     *::operator~();
%rename(__lognot__)	     *::operator~() const;

%rename(__not__)	     *::operator!();
%rename(__not__)	     *::operator!() const;

%rename(__assign__)	     *::operator=;

%rename(__add_assign__)      *::operator+=;
%rename(__sub_assign__)	     *::operator-=;
%rename(__mul_assign__)	     *::operator*=;
%rename(__div_assign__)	     *::operator/=;
%rename(__mod_assign__)	     *::operator%=;
%rename(__logxor_assign__)   *::operator^=;
%rename(__logand_assign__)   *::operator&=;
%rename(__logior_assign__)   *::operator|=;

%rename(__lshift__)	     *::operator<<;
%rename(__lshift_assign__)   *::operator<<=;
%rename(__rshift__)	     *::operator>>;
%rename(__rshift_assign__)   *::operator>>=;

%rename(__eq__)		     *::operator==;
%rename(__ne__)		     *::operator!=;
%rename(__lt__)		     *::operator<;
%rename(__gt__)		     *::operator>;
%rename(__lte__)	     *::operator<=;
%rename(__gte__)	     *::operator>=;

%rename(__and__)	     *::operator&&;
%rename(__or__)		     *::operator||;

%rename(__preincr__)	     *::operator++();
%rename(__postincr__)	     *::operator++(int);
%rename(__predecr__)	     *::operator--();
%rename(__postdecr__)	     *::operator--(int);

%rename(__comma__)	     *::operator,();
%rename(__comma__)	     *::operator,() const;

%rename(__member_ref__)      *::operator->;
%rename(__member_func_ref__) *::operator->*;

%rename(__funcall__)	     *::operator();
%rename(__aref__)	     *::operator[];
#endif


%{

#ifdef __cplusplus
#  define EXTERN   extern "C"
#else
#  define EXTERN   extern
#endif

#define EXPORT   EXTERN SWIGEXPORT

#include <string.h>
#include <stdlib.h>
%}
