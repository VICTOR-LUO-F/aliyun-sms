# Aliyun::Sms 阿里云短信服务 Ruby Gem aliyun-sms

## 特别说明

由于阿里云短信接口将于 2017 年 1 月调整，参数有比较大的变化，目前正在开发新的版本，本仓库暂时不更新。预计2月份会推送新的版本。

## 使用说明

用于阿里云短信服务的 Ruby Gem. 使用这个 Gem 的前提是已经在阿里云注册用户，申请开通了短信服务，
并获得了以下几个关键参数：

1. ACCESS\_KEY\_SECRET： 阿里云接入密钥，在阿里云控制台申请获取。
2. ACCESS\_KEY\_ID：       阿里云接入 ID， 在阿里云控制台申请获取。
3. SIGN\_NAME：           短信签名，在阿里云申请开通短信服务时获取。
4. TEMPLATE\_CODE：       短信模版代码，在阿里云申请开通短信服务时申请获取。

## Installation 安装

### Ruby 通用安装方法
在命令行中输入命令（电脑已经安装 gems 命令行工具）

```ruby
gem install aliyun-sms
```

### Rails 应用安装方法

在应用的 Gemfile 文件中添加 Ruby Gems 安装源:

```ruby
gem 'aliyun-sms'   # Ruby Gems 安装源
```

应用的根目录下运行:

```ruby
bundle
```

### 安装可能遇到的问题及其解决方式  

安装后，如果在 irb 命令行输入下面命令后，无法正确获取 Gem 引用，

```ruby
require 'aliyun/sms'
```

或者，在 Rails 启动时报错提示如下：

> ./config/initializers/aliyun-sms.rb:1:in `<top (required)>': uninitialized constant Aliyun::Sms (NameError)

很可能是镜像安装源与 Ruby Gems 不同步造成的，可以改为 Github 安装源，例如 Rails Gemfile 文件引用可以改为下面格式，即可正确安装。

```ruby
gem 'aliyun-sms', git: 'https://github.com/VICTOR-LUO-F/aliyun-sms.git'
```

## Usage 使用

### Ruby 程序通用方法

#### 第一步：

    $ require 'aliyun/sms'

#### 第二步：

参数设置：

    $ Aliyun::Sms.configure do |config|
          config.access_key_secret = ACCESS_KEY_SECRET # 阿里云接入密钥，在阿里云控制台申请
          config.access_key_id = ACCESS_KEY_ID         # 阿里云接入 ID, 在阿里云控制台申请
          config.action = 'SendSms'                    # 默认设置，如果没有特殊需要，可以不改
          config.format = 'JSON'                       # 短信推送返回信息格式，可以填写 'JSON'或者'XML'
          config.region_id = 'cn-hangzhou'             # 默认设置，如果没有特殊需要，可以不改      
          config.sign_name = SIGN_NAME                 # 短信签名，在阿里云申请开通短信服务时申请获取
          config.signature_method = 'HMAC-SHA1'        # 加密算法，默认设置，不用修改
          config.signature_version = '1.0'             # 签名版本，默认设置，不用修改
          config.sms_version = '2017-05-25'            # 服务版本，默认设置，不用修改
          config.domain = 'dysmsapi.aliyuncs.com'      # 阿里云短信服务器, 默认设置，不用修改
      end

#### 第三步：

发送短信：

    $ Aliyun::Sms.send(phone_number, template_code, param_string)

参数说明：

1. phone_number: 接收短信的手机号，必须为字符型，例如 '1234567890'；
2. template\_code: 短信模版代码，必须为字符型，申请开通短信服务后，由阿里云提供，例如 'SMS_12345678'；
3. para_string: 请求字符串，向短信模版提供参数，必须为字符型的json格式，例如 '{"customer": "username"}'。

### Rails 应用使用方法

#### 第一步：

在 Rails 应用目录 config/initializers/ 下创建脚本文件 aliyun-sms.rb，在文件中加入以下内容：

config/initializers/aliyun-sms.rb

```ruby
Aliyun::Sms.configure do |config|
    config.access_key_secret = ACCESS_KEY_SECRET # 阿里云接入密钥，在阿里云控制台申请
    config.access_key_id = ACCESS_KEY_ID         # 阿里云接入 ID, 在阿里云控制台申请
    config.action = 'SendSms'                    # 默认设置，如果没有特殊需要，可以不改
    config.format = 'JSON'                       # 短信推送返回信息格式，可以填写 'JSON'或者'XML'
    config.region_id = 'cn-hangzhou'             # 默认设置，如果没有特殊需要，可以不改      
    config.sign_name = SIGN_NAME                 # 短信签名，在阿里云申请开通短信服务时申请获取
    config.signature_method = 'HMAC-SHA1'        # 加密算法，默认设置，不用修改
    config.signature_version = '1.0'             # 签名版本，默认设置，不用修改
    config.sms_version = '2017-05-25'            # 服务版本，默认设置，不用修改
    config.domain = 'dysmsapi.aliyuncs.com'      # 阿里云短信服务器, 默认设置，不用修改
  end
```

#### 第二步：

在 Rails 应用中调用短信发送代码：

```ruby
Aliyun::Sms.send(phone_number, template_code, param_string)
```    

参数说明：

1. phone_number: 接收短信的手机号，必须为字符型，例如 '1234567890'；
2. template\_code: 短信模版代码，必须为字符型，申请开通短信服务后，由阿里云提供，例如 'SMS_12345678'；
3. para_string: 请求字符串，向短信模版提供参数，必须为字符型的json格式，例如 '{"customer": "username"}'。

特别说明：

在程序中可以先用 HASH 组织 param\_string 内容，再使用 to_json 方法转换为 json 格式字符串，例如：

```ruby
...
phone_number = '1234567890'
template_code = 'SMS_12345678'
param_string = {'customer' => 'username'}.to_json
Aliyun::Sms.send(phone_number, template_code, param_string)
...
```    

## Development 开发

按照阿里云官方提供的 SMS 签名样例做了简单的 spect 测试，可以 clone 项目后，在根目录下用命令行运行以下命令测试：

    $ bundle exec rspec spec


## License 许可

MIT 协议下的开源项目。 [MIT License](http://opensource.org/licenses/MIT).
