# Aliyun::Sms 阿里云短信服务 Ruby Gem aliyun-sms

**适用于阿里云短信服务最新的 *2017-05-25* 版接口**

## 特别说明

目前阿里云通信提供三个短信产品，分别是：

1. 原阿里大于
2. 阿里云消息服务
3. 阿里云短信服务

这三个短信服务均可使用，并将最终深度融合，综合为一个产品。在合并之前，请注意以下几点：

* 各短信产品账号独立、资金独立；
* 各短信产品内使用数据独立；
* 各短信产品具有自己的 API&SDK，不可兼容使用；
* 同一账号只可使用其中一个产品，不可使用多个产品。

**这个 gem 针对的是前面所述的第 3 个短信产品，即“阿里云短信服务”。请您在使用 aliyun-sms 前，确认自己申请的阿里云短信产品是“阿里云短信服务”，如果无法确定，请参考官方说明文档[阿里云短信业务说明](https://help.aliyun.com/document_detail/63097.html?spm=a2c4g.11186623.6.542.6fZlRU)进行区分。**

## 使用前提

使用 aliyun-sms 前，您必须已经是阿里云注册用户，申请开通了“阿里云短信服务”，并且获得了以下几个关键参数：

1. ACCESS\_KEY\_SECRET：   阿里云用户密钥，在阿里云控制台申请获取。
2. ACCESS\_KEY\_ID：       阿里云用户 ID， 在阿里云控制台申请获取。
3. SIGN\_NAME：            短信签名，在阿里云申请开通短信服务时获取。
4. TEMPLATE\_CODE：        短信模版代码，在阿里云申请开通短信服务时申请获取。

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

### 下载后安装

使用 Git 将代码克隆到本地后使用 Rake 命令安装

```bash
git clone https://github.com/VICTOR-LUO-F/aliyun-sms.git

cd aliyun-sms

rake build

rake install
```

### 安装可能遇到的问题及其解决方式  

安装后，如果在 irb 命令行输入命令

```ruby
require 'aliyun/sms'
```

后，无法正确获取 Gem 引用，或者在 Rails 启动时报错提示如下：

> ./config/initializers/aliyun-sms.rb:1:in `<top (required)>': uninitialized constant Aliyun::Sms (NameError)

可以改为 Github 安装源，例如 Rails Gemfile 文件引用可以改为下面格式，即可正确安装。

```ruby
gem 'aliyun-sms', git: 'https://github.com/VICTOR-LUO-F/aliyun-sms.git'
```

## Usage 使用

### Ruby 程序通用方法（irb命令行示例）

#### 第一步：

    $ require 'aliyun/sms'

#### 第二步：

参数设置：

```ruby
$ Aliyun::Sms.configure do |config|
    config.access_key_secret = ACCESS_KEY_SECRET    # 阿里云接入密钥，在阿里云控制台申请
    config.access_key_id = ACCESS_KEY_ID            # 阿里云接入 ID, 在阿里云控制台申请
    config.action = 'SendSms'                       # 默认设置
    config.format = 'XML'                           # 短信推送返回信息格式，可以填写 'JSON'或者'XML'
    config.region_id = 'cn-hangzhou'                # 默认设置，如果没有特殊需要，可以不改      
    config.sign_name = SIGN_NAME                    # 短信签名，在阿里云申请开通短信服务时申请获取
    config.signature_method = 'HMAC-SHA1'           # 加密算法，默认设置
    config.signature_version = '1.0'                # 签名版本，默认设置，不用修改
    config.version = '2017-05-25'                   # 服务版本，默认设置，不用修改
  end

```
返回

```ruby
  => "2017-05-25"
```

#### 第三步：

发送短信：

    $ Aliyun::Sms.send(phone_numbers, template_code, template_param, out_id)
    
参数说明：

1. phone_numbers： 接收短信的手机号，必须为字符型，例如 '1234567890'，如果有多个号码，中间用","隔开，例如：'1234567890,12388888888'；
2. template\_code： 短信模版代码，必须为字符型，申请开通短信服务后，由阿里云提供，例如 'SMS_12345678'；
3. template_param： 请求字符串，向短信模版提供参数，必须是转为字符串的json格式对象，例如 '{"code":"666666", "product":"测试网站" }'；
4. out_id：外部流水扩展字段，必须为字符型，可以为空。


### Rails 应用使用方法

#### 第一步：

在 Rails 应用目录 config/initializers/ 下创建脚本文件 aliyun-sms.rb，在文件中加入以下内容：

config/initializers/aliyun-sms.rb

```ruby
Aliyun::Sms.configure do |config|
  config.access_key_secret = ACCESS_KEY_SECRET    # 阿里云接入密钥，在阿里云控制台申请
  config.access_key_id = ACCESS_KEY_ID            # 阿里云接入 ID, 在阿里云控制台申请
  config.action = 'SendSms'                       # 默认设置
  config.format = 'XML'                           # 短信推送返回信息格式，可以填写 'JSON'或者'XML'
  config.region_id = 'cn-hangzhou'                # 默认设置，如果没有特殊需要，可以不改      
  config.sign_name = SIGN_NAME                    # 短信签名，在阿里云申请开通短信服务时申请获取
  config.signature_method = 'HMAC-SHA1'           # 加密算法，默认设置
  config.signature_version = '1.0'                # 签名版本，默认设置，不用修改
  config.version = '2017-05-25'                   # 服务版本，默认设置，不用修改
end
```
之后，重新启动 Rails，加载配置。 

#### 第二步：

在 Rails 应用中调用短信发送代码：

```ruby
Aliyun::Sms.send(phone_numbers, template_code, template_param, out_id)
```    

参数说明：

1. phone_numbers： 接收短信的手机号，必须为字符型，例如 '1234567890'，如果有多个号码，中间用","隔开，例如：'1234567890,12388888888'；
2. template\_code： 短信模版代码，必须为字符型，申请开通短信服务后，由阿里云提供，例如 'SMS_12345678'；
3. template_param： 请求字符串，向短信模版提供参数，必须是转为字符串的json格式对象，例如 '{"code":"666666", "product":"测试网站" }'；
4. out_id：外部流水扩展字段，必须为字符型，可以为空。

特别说明：

在程序中可以先用 HASH 组织 template\_param 内容，再使用 to_json 方法转换为 json 格式字符串，例如：

```ruby
...
phone_number = '1234567890'
template_code = 'SMS_12345678'
template_param = {"code"=>"666666", "product"=>"测试网站" }.to_json
Aliyun::Sms.send(phone_numbers, template_code, template_param)
...
```    

## Development 开发

按照阿里云[官方接口文档](https://help.aliyun.com/document_detail/56189.html?spm=a2c4g.11186623.6.580.o8Fm0S)提供的 SMS 样例做了 spect 测试，可以 clone 项目后，在根目录下用命令行运行以下命令测试：

    $ bundle exec rspec spec


## License 许可

MIT 协议下的开源项目。 [MIT License](http://opensource.org/licenses/MIT).
