#ifndef __RUBY_BINLOG_H__
#define __RUBY_BINLOG_H__

// XXX:
#define private public

#include <string>
#include <ruby.h>
#include <binlog_api.h>

#ifndef RUBY_UBF_IO
#include <rubysig.h>
#endif

#include "ruby_binlog_event.h"

#ifndef RSTRING_PTR
#define RSTRING_PTR(s) (RSTRING(s)->ptr)
#endif
#ifndef RSTRING_LEN
#define RSTRING_LEN(s) (RSTRING(s)->len)
#endif

#ifdef _WIN32
#define __F(f) (reinterpret_cast<VALUE (__cdecl *)(...)>(f))
#else
#define __F(f) (reinterpret_cast<VALUE (*)(...)>(f))
#endif

#define WAIT_INTERVAL 300

extern VALUE rb_mBinlog;
extern VALUE rb_eBinlogError;

namespace ruby {
namespace binlog {
const char* get_field_type_str(enum_field_types type);
mysql::system::Binlog_tcp_driver *cast_to_tcp_driver(mysql::system::Binary_log_driver *driver);
} // namespace binlog
} // namespace ruby

extern "C" {
#ifdef _WIN32
__declspec(dllexport)
#endif
void Init_binlog();
}

#endif // __RUBY_BINLOG_H__
