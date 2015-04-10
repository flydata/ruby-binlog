#!/usr/bin/env ruby
require "rubygems"

def append_load_path_if_not_exist(new_lib_path)
  absolute_path = File.realpath(new_lib_path)
  $LOAD_PATH.unshift absolute_path unless $LOAD_PATH.include? absolute_path
end
ext_dir = File.realpath('../../ext', __FILE__)
append_load_path_if_not_exist(ext_dir)

require "binlog"

master_log_file = nil
master_log_pos = nil

# mysql://user:pass@fqdn
mysql_url = if ARGV[0]
              ARGV[0]
            else
              "mysql://root:@127.0.0.1"
            end

ssl_ca = ARGV[1] if ARGV[1]

begin
  # XXX: Do not reuse a client instance, after connection goes out.
  client = Binlog::Client.new(mysql_url)

  sleep 0.5 until client.connect

  if master_log_file and master_log_pos
    client.set_position(master_log_file, master_log_pos)
  else
    client.set_position(4)
  end

  while event = client.wait_for_next_event
    puts "(#{event.event_type}) cur_pos:#{master_log_pos} next_pos:#{event.next_position}"
    master_log_pos = event.next_position

    case event
    when Binlog::QueryEvent
      puts event.db_name
      puts event.query
    when Binlog::RowEvent
      puts event.event_type
      puts event.db_name
      puts event.table_name
      p event.columns
      p event.rows
    when Binlog::RotateEvent
      master_log_file = event.binlog_file
      master_log_pos = event.binlog_pos
    end
    sleep 0.5
  end
rescue Binlog::Error => e
  puts e
  if client.closed?
    sleep 1.5
    puts "Retrying reconnect to mysql server..."
    retry
  end
  raise e
end
