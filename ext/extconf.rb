require 'mkmf'

# mysql-replication-listener
dir_config('replication')

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

# OpenSSL
dir_config('openssl')

case explicit_rpath = with_config('openssl-rpath')
when true
  abort "-----\nOption --with-openssl-rpath must have an argument\n-----"
when false
  warn "-----\nOption --with-openssl-rpath has been disabled at your request\n-----"
when String
  # The user gave us a value so use it
  rpath_flags = " -Wl,-rpath,#{explicit_rpath}"
  warn "-----\nSetting openssl rpath to #{explicit_rpath}\n-----"
  $LDFLAGS << rpath_flags
end

if have_library('stdc++') and have_library('replication')
  create_makefile('binlog')
end
