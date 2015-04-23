require 'mkmf'

dir_config('replication')
dir_config('mysql')

if have_library('stdc++') and have_library('replication')
  create_makefile('binlog')
end
