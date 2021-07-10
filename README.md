## [中文说明](./README.zh-CN.md)

# An **UNOFFICIAL** Aliyun SMS RubyGem

**Compatible with Aliyun SMS *2017-05-25 version* API**

## Notice

Currently, Aliyun has three different services of SMS：

1. ali-dayu (阿里大于)
2. aliyun-mq (阿里云消息队列)
3. aliyun-sms (阿里云短信服务)

All of these services are currently available, but would be merged into a single product in the future.

You might be using services other than aliyun-sms, but **this gem only for aliyun-sms (阿里云短信服务) ONLY**.

**Check Aliyun Official Documentation [阿里云短信业务说明](https://help.aliyun.com/document_detail/63097.html?spm=a2c4g.11186623.6.542.6fZlRU) for details.**

## Requirements

Before using aliyun-sms, you must apply and enable the aliyun-sms service, parameters as follows are **required**:

1. ACCESS\_KEY\_SECRET：   apply it on aliyun console
2. ACCESS\_KEY\_ID：       apply it on aliyun console
3. SIGN\_NAME：            defined in aliyun-sms
4. TEMPLATE\_CODE：        defined in aliyun-sms

## Installation

### Gem

```ruby
gem install aliyun-sms
```

### With Bundler

Add the following line in Gemfile :

```ruby
gem 'aliyun-sms'
```

Then Run the following command:

```ruby
bundle
```

### Manual Installation

Clone and install the gem by rake.

```bash
git clone https://github.com/VICTOR-LUO-F/aliyun-sms.git

cd aliyun-sms

rake build

rake install
```

### FAQ

```ruby
require 'aliyun/sms'
```

If you get a error as follows, when running above command：

> ./config/initializers/aliyun-sms.rb:1:in `<top (required)>': uninitialized constant Aliyun::Sms (NameError)

Update your Gem to a later version.

## Usage

### Basic Usages

```ruby
require 'aliyun/sms'

Aliyun::Sms.configure do |config|
  config.access_key_secret = ACCESS_KEY_SECRET    
  config.access_key_id = ACCESS_KEY_ID            
  config.action = 'SendSms'                       # default value
  config.format = 'XML'                           # http return format, value is 'JSON' or 'XML'
  config.region_id = 'cn-hangzhou'                # default value      
  config.sign_name = SIGN_NAME                  
  config.signature_method = 'HMAC-SHA1'           # default value
  config.signature_version = '1.0'                # default value
  config.version = '2017-05-25'                   # default value
end
```

Send message：

```ruby
Aliyun::Sms.send(phone_numbers, template_code, template_param, out_id)
```

Parameters:

1. phone_numbers: the phone number, string type, such as '1234567890'. You can use multiple phone numbers devided by comma, such as '1234567890,12388888888'.
2. template_code: message template code, string type, such as 'SMS_12345678'.
3. template_param: message template params, tring type, such as '{"code":"666666", "product":"content" }'.
4. out_id: out extension id，string type，could be `nil`.


### Rails Application

#### Initialization

In Rails directory 'config/initializers/', create the file 'aliyun-sms.rb', and add the following code：           


`config/initializers/aliyun-sms.rb`

```ruby
Aliyun::Sms.configure do |config|
  config.access_key_secret = ACCESS_KEY_SECRET    
  config.access_key_id = ACCESS_KEY_ID            
  config.action = 'SendSms'                       # default value
  config.format = 'XML'                           # http return format, value is 'JSON' or 'XML'
  config.region_id = 'cn-hangzhou'                # default value      
  config.sign_name = SIGN_NAME                    
  config.signature_method = 'HMAC-SHA1'           # default value
  config.signature_version = '1.0'                # default value
  config.version = '2017-05-25'                   # default value
end
```
then, restart your Rails application。

#### Send Messages

Send your message in your program:

```ruby
Aliyun::Sms.send(phone_numbers, template_code, template_param, out_id)
```    

Explanation：

1. phone_numbers: the phone number, string type, such as '1234567890'. You can use multiple phone numbers devided by comma, such as '1234567890,12388888888'.
2. template_code: message template code, string type, such as 'SMS_12345678'.
3. template_param: message template params, tring type, such as '{"code":"666666", "product":"content" }'.
4. out_id: out extension id，string type，could be `nil`.

NOTICE:

Since the `template_param` is a string, convert the hash into json string before calling the method.

```ruby
...
phone_number = '1234567890'
template_code = 'SMS_12345678'
template_param = {"code"=>"666666", "product"=>"content" }.to_json
Aliyun::Sms.send(phone_numbers, template_code, template_param)
...
```    

## Test

Spec tests covered the example provied in the [Aliyun Official Document](https://help.aliyun.com/document_detail/56189.html?spm=a2c4g.11186623.6.580.o8Fm0S). You could run the test after clone as follows:

    $ bundle exec rspec spec


## License

[MIT License](http://opensource.org/licenses/MIT).
