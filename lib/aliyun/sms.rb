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
                    :sign_name, :signature_method, :signature_version, :sms_version
      def initialize
        @access_key_secret = ''
        @access_key_id = ''
        @action = ''
        @format = ''
        @region_id = ''
        @sign_name = ''
        @signature_method = ''
        @signature_version = ''
        @sms_version = ''
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

      def create_params(mobile_num, template_code, message_param)
        sms_params ={
          'AccessKeyId' => configuration.access_key_id,
          'Action' => configuration.action,
          'Format' => configuration.format,
          'ParamString' => message_param,
          'RecNum' => mobile_num,
          'RegionId' => configuration.region_id,
          'SignName' => configuration.sign_name,
          'SignatureMethod' => configuration.signature_method,
          'SignatureNonce' => seed_signature_nonce,
          'SignatureVersion' => configuration.signature_version,
          'TemplateCode' => template_code,
          'Timestamp' => seed_timestamp,
          'Version' => configuration.sms_version,
        }
      end

      def send(mobile_num, template_code, message_param)
        sms_params = create_params(mobile_num, template_code, message_param)
        Typhoeus.get(configuration.domain,
                 params: get_query_params(configuration.access_key_secret, sms_params))
      end

      # 原生参数经过2次编码拼接成标准字符串
      def canonicalized_query_string(params)
        cqstring = ''
        params.each do |key, value|
          if cqstring.empty?
            cqstring += "#{encode(key)}=#{encode(value)}"
          else
            cqstring += "&#{encode(key)}=#{encode(value)}"
          end
        end
        return cqstring
      end

      # 生成数字签名
      def sign(key_secret, params)
        key = key_secret + '&'
        signature = 'GET' + '&' + encode('/') + '&' + encode(canonicalized_query_string(params))
        digest = OpenSSL::Digest.new('sha1')
        sign = Base64.encode64(OpenSSL::HMAC.digest(digest, key, signature))
        encode(sign.chomp) # 通过chomp去掉最后的换行符 LF
      end

      # 组成附带签名的 GET 方法的 QUERY 请求字符串
      def get_query_params(key_secret, params)
        query_params = 'Signature=' + sign(key_secret, params) + '&' + canonicalized_query_string(params)
      end

      # 对字符串进行 PERCENT 编码
      def encode(input)
        output = url_encode(input)
        # useless replace, according to https://help.aliyun.com/document_detail/56189.html
        output.gsub(/\+/, '%20')
              .gsub(/\*/, '%2A')
              .gsub(/%7E/, '~')
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
