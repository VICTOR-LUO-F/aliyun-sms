require "aliyun/sms/version"
require "openssl"
require "base64"
require 'faraday'
require 'cgi'
require 'uri'

module Aliyun
  module Sms
    class Configuration
      attr_accessor :access_key_secret, :access_key_id, :action, :format, :region_id,
                    :sign_name, :signature_method, :signature_version, :version

      def initialize
        @access_key_secret = ''
        @access_key_id = ''
        @action = ''
        @format = ''
        @region_id = ''
        @sign_name = ''
        @signature_method = ''
        @signature_version = ''
        @version = ''
      end
    end

    class << self
      attr_writer :configuration

      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield(configuration)
      end

      def send(phone_numbers, template_code, template_param, out_id = '')
        send_params = {
          'PhoneNumbers' => phone_numbers,
          'TemplateCode' => template_code,
          'TemplateParam' => template_param,
          'OutId'	=> out_id,
          'SignatureNonce' => seed_signature_nonce,
          'Timestamp' => seed_timestamp
        }

        Faraday.get('https://dysmsapi.aliyuncs.com', get_params(send_params))
      end

      def get_params(user_params)
        params = config_params.merge(user_params)
        key_secret = configuration.access_key_secret
        params['Signature'] = sign(key_secret, params)
        params
      end

      def config_params
        {
          'AccessKeyId' => configuration.access_key_id,
          'Action' => configuration.action,
          'Format' => configuration.format,
          'RegionId' => configuration.region_id,
          'SignName' => configuration.sign_name,
          'SignatureMethod' => configuration.signature_method,
          'SignatureVersion' => configuration.signature_version,
          'Version' => configuration.version
        }
      end

      # 生成数字签名
      def sign(key_secret, params)
        str_to_sign = "GET&%2F&#{special_url_encode(URI.encode_www_form(params.sort.to_h))}"
        special_url_encode(Base64.strict_encode64("#{OpenSSL::HMAC.digest('sha1', "#{key_secret}&", str_to_sign)}"))
      end

      # 对字符串进行 POP 编码
      # 参考文档：https://help.aliyun.com/document_detail/101343.html?spm=a2c4g.11186623.6.627.79bb1089drq7U4
      # 首先介绍下面会用到的特殊 URL 编码这个是 POP 特殊的一种规则，即在一般的 URLEncode 后再增加三种字符替换：
      # 加号（+）替换成 %20、星号（*）替换成 %2A、%7E 替换回波浪号（~）
      def special_url_encode(input)
        CGI.escape(input).gsub('+', '%20').gsub('*', '%2A').gsub('%7E', '~')
      end

      # 生成短信时间戳
      def seed_timestamp
        Time.now.utc.strftime("%FT%TZ")
      end

      # 生成短信唯一标识码，采用到微秒的时间戳
      def seed_signature_nonce
        Time.now.utc.strftime("%Y%m%d%H%M%S%L")
      end
    end
  end
end
