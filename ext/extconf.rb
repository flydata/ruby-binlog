require 'mkmf'

HEADER_DIRS = [
  '/opt/flydata/include',
  '/usr/local/include',
  '/usr/include',
]

LIB_DIRS = [
  '/opt/flydata/lib',
  '/usr/local/lib',
  '/usr/lib',
]

dir_config('replication', HEADER_DIRS, LIB_DIRS)

if have_library('stdc++') and have_library('replication')
  create_makefile('binlog')
end
