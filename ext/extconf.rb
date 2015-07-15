require 'mkmf'

LIBDIR      = RbConfig::CONFIG['libdir']
INCLUDEDIR  = RbConfig::CONFIG['includedir']

HEADER_DIRS = [
  '/opt/local/include',
  '/usr/local/include',
  INCLUDEDIR,
  '/usr/include',
]

LIB_DIRS = [
  '/opt/local/lib',
  '/usr/local/lib',
  LIBDIR,
  '/usr/lib',
]

dir_config('replication', HEADER_DIRS, LIB_DIRS)

case explicit_rpath = with_config('replication-rpath')
when true
  abort "-----\nOption --with-replication-rpath must have an argument\n-----"
when false
  warn "-----\nOption --with-replication-rpath has been disabled at your request\n-----"
when String
  # The user gave us a value so use it
  rpath_flags = " -Wl,-rpath,#{explicit_rpath}"
  warn "-----\nSetting replication rpath to #{explicit_rpath}\n-----"
  $LDFLAGS << rpath_flags
end

if have_library('stdc++') and have_library('replication')
  create_makefile('binlog')
end
