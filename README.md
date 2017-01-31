# Aliyun::Sms

用于阿里云短信服务的 Ruby Gem. 使用这个 gem 的前提是你已经在阿里云注册用户，并申请了开通了短信服务，
并获得了以下几个关键参数：

1、ACCESS_KEY_SECRET, 阿里云接入密钥，在阿里云控制台申请获取；
2、ACCESS_KEY_ID,     阿里云接入 ID, 在阿里云控制台申请
3、SIGN_NAME,         短信签名，在阿里云申请开通短信服务时申请获取
4、TEMPLATE_CODE,     短信模版代码，，在阿里云申请开通短信服务时申请获取

## Installation 安装

在您的应用的 Gemfile 文件中添加下面一行:

```ruby
gem 'aliyun-sms'
```

然后在应用的根目录下运行:

    $ bundle

或则使用 gem 命令行安装，命令如下:

    $ gem install aliyun-sms

## Usage 使用

### ruby 程序通用方法

#### 第一步：

    $ require 'aliyun/sms'

#### 第二步：

参数设置：

    $ Aliyun::Sms.configure do |config|
          config.access_key_secret = ACCESS_KEY_SECRET # 阿里云接入密钥，在阿里云控制台申请
          config.access_key_id = ACCESS_KEY_ID         # 阿里云接入 ID, 在阿里云控制台申请
          config.action = 'SingleSendSms'              # 默认设置，如果没有特殊需要，可以不改
          config.format = 'JSON'                       # 短信推送返回信息格式，可以填写 'JSON'或者'XML'
          config.region_id = 'cn-hangzhou'             # 默认设置，如果没有特殊需要，可以不改      
          config.sign_name = SIGN_NAME                 # 短信签名，在阿里云申请开通短信服务时申请获取
          config.signature_method = 'HMAC-SHA1'        # 加密算法，默认设置，不用修改
          config.signature_version = '1.0'             # 签名版本，默认设置，不用修改
          config.sms_version = '2016-09-27'            # 服务版本，默认设置，不用修改
      end

#### 第三步：

发送短信：

    $ Aliyun::Sms.send(phone_number, template_code, param_string)

参数说明：

   1、phone_number: 接收短信的手机号，必须为字符型，例如 '1234567890'；

   2、template_code: 短信模版代码，必须为字符型，申请开通短信服务后，由阿里云提供，例如 'SMS_12345678'；

   3、para_string: 请求字符串，向短信模版提供参数，必须为字符型的json格式，例如 '{"customer": "username"}'。

### rails 应用使用方法

#### 第一步：

在 rails 应用目录 config/initializers/ 下创建脚本文件 aliyun-sms.rb，在文件中加入以下内容：

config/initializers/aliyun-sms.rb

```ruby
Aliyun::Sms.configure do |config|
    config.access_key_secret = ACCESS_KEY_SECRET # 阿里云接入密钥，在阿里云控制台申请
    config.access_key_id = ACCESS_KEY_ID         # 阿里云接入 ID, 在阿里云控制台申请
    config.action = 'SingleSendSms'              # 默认设置，如果没有特殊需要，可以不改
    config.format = 'JSON'                       # 短信推送返回信息格式，可以填写 'JSON'或者'XML'
    config.region_id = 'cn-hangzhou'             # 默认设置，如果没有特殊需要，可以不改      
    config.sign_name = SIGN_NAME                 # 短信签名，在阿里云申请开通短信服务时申请获取
    config.signature_method = 'HMAC-SHA1'        # 加密算法，默认设置，不用修改
    config.signature_version = '1.0'             # 签名版本，默认设置，不用修改
    config.sms_version = '2016-09-27'            # 服务版本，默认设置，不用修改
  end
```

#### 第二步：

在 rails 应用中调用短信发送代码：

```ruby
Aliyun::Sms.send(phone_number, template_code, param_string)
```    

参数说明：

1、phone_number: 接收短信的手机号，必须为字符型，例如 '1234567890'；

2、template_code: 短信模版代码，必须为字符型，申请开通短信服务后，由阿里云提供，例如 'SMS_12345678'；

3、para_string: 请求字符串，向短信模版提供参数，必须为字符型的json格式，例如 '{"customer": "username"}'。

特别说明：

在程序中可以先用 HASH 组织 para_string 内容，再使用 to_json 方法转换为 json 格式字符串，例如：

```ruby
...
phone_number = '1234567890'
template_code = 'SMS_12345678'
param_string = {'customer' => 'username'}.to_json
Aliyun::Sms.send(phone_number, template_code, param_string)
...
```    

## Development 开发

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

按照 阿里云官方提供的 sms 签名样例做了简单的 spect 测试，可以在项目根目录下，用命令行运行以下命令测试：

    $ bundle exec rspec spec

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/VICTOR/aliyun-sms. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
