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
                    :sign_name, :signature_method, :signature_version, :sms_version,
                    :domain
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
        @domain = ''
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
          'PhoneNumbers' => mobile_num,
          'RegionId' => configuration.region_id,
          'SignName' => configuration.sign_name,
          'SignatureMethod' => configuration.signature_method,
          'SignatureNonce' => seed_signature_nonce,
          'SignatureVersion' => configuration.signature_version,
          'TemplateCode' => template_code,
          'TemplateParam' => message_param,
          'Timestamp' => seed_timestamp,
          'Version' => configuration.sms_version,
        }
      end

      def send(mobile_num, template_code, message_param)
        sms_params = create_params(mobile_num, template_code, message_param)
        Typhoeus.post(configuration.domain,
                 headers: {'Content-Type'=> "application/x-www-form-urlencoded"},
                 body: post_body_data(configuration.access_key_secret, sms_params))
      end

      # 原生参数拼接成请求字符串
      def query_string(params)
        qstring = ''

        # Canonicalized Query String/使用请求参数构造规范化的请求字符串
        # 按照参数名称的字典顺序对请求中所有的请求参数进行排序
        params = params.sort.to_h

        params.each do |key, value|
          if qstring.empty?
            qstring += "#{key}=#{value}"
          else
            qstring += "&#{key}=#{value}"
          end
        end
        return qstring
      end

      # 原生参数经过2次编码拼接成标准字符串
      def canonicalized_query_string(params)
        cqstring = ''

        # Canonicalized Query String/使用请求参数构造规范化的请求字符串
        # 按照参数名称的字典顺序对请求中所有的请求参数进行排序
        params = params.sort.to_h

        params.each do |key, value|
          if cqstring.empty?
            cqstring += "#{encode(key)}=#{encode(value)}"
          else
            cqstring += "&#{encode(key)}=#{encode(value)}"
          end
        end
        return encode(cqstring)
      end

      # 生成数字签名
      def sign(key_secret, params)
        key = key_secret + '&'
        signature = 'POST' + '&' + encode('/') + '&' + canonicalized_query_string(params)
        digest = OpenSSL::Digest.new('sha1')
        sign = Base64.encode64(OpenSSL::HMAC.digest(digest, key, signature))
        encode(sign.chomp) # 通过chomp去掉最后的换行符 LF
      end

      # 组成附带签名的 POST 方法的 BODY 请求字符串
      def post_body_data(key_secret, params)
        body_data = 'Signature=' + sign(key_secret, params) + '&' + query_string(params)
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

    end

  end
end
