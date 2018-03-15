## [中文说明](./README.zh-CN.md)

# Aliyun::Sms  Ruby Gem for Aliyun Short Message Service(aliyun-sms)

**Comfortable to aliyun sms  *2017-05-25 version* api**

## Notice

Currently, aliyun has three services of short message，named：

1. ali-dayu(阿里大于)
2. aliyun-mq(阿里云消息队列)
3. aliyun-sms(阿里云短信服务)

They all are usable, and will merge togather in future. But before merged, they are Independent, and every user only use one between them.

**This gem only for aliyun-sms(阿里云短信服务), and you must confirm that you just use it. If you can't confirm, please see the document [阿里云短信业务说明](https://help.aliyun.com/document_detail/63097.html?spm=a2c4g.11186623.6.542.6fZlRU) to get guidance.**

## Before

Before use aliyun-sms, you must apply and open the aliyun-sms, and get the parameters as follows:

1. ACCESS\_KEY\_SECRET：   apply on aliyun console
2. ACCESS\_KEY\_ID：       apply on aliyun console
3. SIGN\_NAME：            get when open the aliyun-sms
4. TEMPLATE\_CODE：        get when open the aliyun-sms

## Installation

### Ruby Common Method


```ruby
gem install aliyun-sms
```

### Rails Method

Add in Gemfile :

```ruby
gem 'aliyun-sms'   # Ruby Gems 安装源
```

Run command:

```ruby
bundle
```

### Download Method

Clone and install by rake.

```bash
git clone https://github.com/VICTOR-LUO-F/aliyun-sms.git

cd aliyun-sms

rake build

rake install
```

### Problem and Resolve

```ruby
require 'aliyun/sms'
```

If you get a error as follows, when running above command：

> ./config/initializers/aliyun-sms.rb:1:in `<top (required)>': uninitialized constant Aliyun::Sms (NameError)

You could switch to github resource, and modify the the Rails Gemfile to:

```ruby
gem 'aliyun-sms', '1.1.1', git: 'https://github.com/VICTOR-LUO-F/aliyun-sms.git'
```

## Usage

### Ruby Common Program（irb）

#### First Step：

```bash
$ require 'aliyun/sms'
```

return

```bash
=> true
```

#### Second Step：


```ruby
$ Aliyun::Sms.configure do |config|
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
return

```ruby
  => "2017-05-25"
```

#### Third Step：

Send message：

    $ Aliyun::Sms.send(phone_numbers, template_code, template_param, out_id)

Explanation：

1. phone_numbers： the phone number, string type, such as '1234567890'. You can use multiple phone numbers devided by comma, such as '1234567890,12388888888'.
2. template\_code： message template code, string type, such as 'SMS_12345678'.
3. template_param： message template params, tring type, such as '{"code":"666666", "product":"content" }'.
4. out_id：out extension id，string type，could be null。


### Rails Application

#### First Step：

In Rails direction 'config/initializers/', create file 'aliyun-sms.rb', and add code：           


config/initializers/aliyun-sms.rb

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
then, restart Rails application。

#### Second Step：

Send message in your program：

```ruby
Aliyun::Sms.send(phone_numbers, template_code, template_param, out_id)
```    

Explanation：

1. phone_numbers： the phone number, string type, such as '1234567890'. You can use multiple phone numbers devided by comma, such as '1234567890,12388888888'.
2. template\_code： message template code, string type, such as 'SMS_12345678'.
3. template_param： message template params, tring type, such as '{"code":"666666", "product":"content" }'.
4. out_id：out extension id，string type，could be null。

Specially：

In Rails application program, you could organize your message content as a hash, and trans it bo be a param of Aliyun::Sms.send by to_json method. For instance:

```ruby
...
phone_number = '1234567890'
template_code = 'SMS_12345678'
template_param = {"code"=>"666666", "product"=>"conten" }.to_json
Aliyun::Sms.send(phone_numbers, template_code, template_param)
...
```    

## Development

According to [Aliyun Official Document](https://help.aliyun.com/document_detail/56189.html?spm=a2c4g.11186623.6.580.o8Fm0S) example, I had written spect test. You could run the test after clone as follows:

    $ bundle exec rspec spec


## License

MIT License。 [MIT License](http://opensource.org/licenses/MIT).
