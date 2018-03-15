# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aliyun/sms/version'

Gem::Specification.new do |spec|
  spec.name          = "aliyun-sms"
  spec.version       = Aliyun::Sms::VERSION
  spec.authors       = ["VICTOR LUO"]
  spec.email         = ["victor-luo@outlook.com"]

  spec.summary       = %q{A Ruby Gem for using aliyun sms service, in accordance with aliyun sms 2017-05-25 version api. 适用于阿里云短信服务最新的 2017-05-25 版接口.}
  spec.description   = %q{A Ruby Gem for using aliyun sms service, in accordance with aliyun sms 2017-05-25 version api. 适用于阿里云短信服务最新的 2017-05-25 版接口.}
  spec.homepage      = "https://github.com/VICTOR-LUO-F/aliyun-sms"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_dependency "typhoeus"
end
