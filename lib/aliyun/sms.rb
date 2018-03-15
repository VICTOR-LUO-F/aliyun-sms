require "aliyun/sms/version"
require "openssl"
require "base64"
require 'typhoeus/adapters/faraday'
require "erb"
include ERB::Util

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
        Typhoeus.get(get_url({
          'PhoneNumbers' => phone_numbers,
          'TemplateCode' => template_code,
          'TemplateParam' => template_param,
          'OutId'	=> out_id,
          'SignatureNonce' => seed_signature_nonce,
          'Timestamp' => seed_timestamp
          }))
      end

      def get_url(user_params)
        params = get_params(user_params)
        coded_params = canonicalized_query_string(params)
        key_secret = configuration.access_key_secret
        url = 'http://dysmsapi.aliyuncs.com/?' + 'Signature=' + sign(key_secret, coded_params) + '&' + coded_params
      end

      def get_params(user_params)
        params = config_params.merge(user_params)
      end

      def config_params()
        params ={
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

      def canonicalized_query_string(params)
        cqstring = ''
        params.sort_by{|key, val| key}.each do |key, value|
          if cqstring.empty?
            cqstring += "#{encode(key)}=#{encode(value)}"
          else
            cqstring += "&#{encode(key)}=#{encode(value)}"
          end
        end
        cqstring
      end

      # 生成数字签名
      def sign(key_secret, coded_params)
        key = key_secret + '&'
        signature = 'GET' + '&' + encode('/') + '&' +  encode(coded_params)
        sign = Base64.encode64("#{OpenSSL::HMAC.digest('sha1',key, signature)}")
        encode(sign.chomp)  # 通过chomp去掉最后的换行符 LF
      end

      # 对字符串进行 PERCENT 编码
      def encode(input)
        output = url_encode(input)
      end

      # 生成短信时间戳
      def seed_timestamp
        Time.now.utc.strftime("%FT%TZ")
      end

      # 生成短信唯一标识码，采用到微秒的时间戳
      def seed_signature_nonce
        Time.now.utc.strftime("%Y%m%d%H%M%S%L")
      end

      # 测试参数未编码时生成的字符串是否正确（多一道保险）
      def test_query_string(params)
        qstring = ''
        params.sort_by{|key, val| key}.each do |key, value|
          if qstring.empty?
            qstring += "#{key}=#{value}"
          else
            qstring += "&#{key}=#{value}"
          end
        end
        qstring
      end

    end

  end
end
