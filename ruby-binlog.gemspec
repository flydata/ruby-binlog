Gem::Specification.new do |spec|
  spec.name              = 'ruby-binlog'
  spec.version           = '1.0.0'
  spec.summary           = 'Ruby binding for MySQL Binary log API.'
  spec.description       = 'Ruby binding for MySQL Binary log API.'
  spec.files             = Dir.glob('ext/{*.cpp,*.h,extconf.rb}') + %w(README)
  spec.author            = 'winebarrel'
  spec.email             = 'sgwr_dts@yahoo.co.jp'
  spec.homepage          = 'https://bitbucket.org/winebarrel/ruby-binlog'
  spec.extensions        = 'ext/extconf.rb'
  spec.has_rdoc          = true
  spec.rdoc_options      << '--title' << 'ruby-binlog - Ruby binding for MySQL Binary log API.'
  spec.extra_rdoc_files  = %w(README)
end
