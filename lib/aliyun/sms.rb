require "aliyun/sms/version"
require "openssl"
require "base64"
require "typhoeus"
require "json"
require "erb"
include ERB::Util

module Aliyun
  module Sms
    class << self
      # 通过常量设置参数
      ACCESS_KEY_SECRET = 'xxxxxxx'
      ACCESS_KEY_ID = 'xxxxxx'
      ACTION = 'SingleSendSms'
      FORMAT = 'JSON'
      REGION_ID = 'cn-hangzhou'
      SIGN_NAME = 'xxxxx'
      SIGNATURE_METHOD = 'HMAC-SHA1'
      SIGNATURE_VERSION ='1.0'
      SMS_VERSION = '2016-09-27'

      def create_params(mobile_num, template_code, message_param)
        sms_params ={
          'AccessKeyId' => ACCESS_KEY_ID,
          'Action' => ACTION,
          'Format' => FORMAT,
          #'ParamString' => PARAM_STRING,
          'ParamString' => message_param,
          #'RecNum' => REC_NUM,
          'RecNum' => mobile_num,
          'RegionId' => REGION_ID,
          'SignName' => SIGN_NAME,
          'SignatureMethod' => SIGNATURE_METHOD,
          'SignatureNonce' => seed_signature_nonce,
          'SignatureVersion' => SIGNATURE_VERSION,
          #'TemplateCode' => TEMPLATE_CODE,
          'TemplateCode' => template_code,

          'Timestamp' => seed_timestamp,
          'Version' => SMS_VERSION,
        }
      end

      def send(mobile_num, template_code, message_param)
        sms_params = create_params(mobile_num, template_code, message_param)
        Typhoeus.post("http://sms.aliyuncs.com/",
                 headers: {'Content-Type'=> "application/x-www-form-urlencoded"},
                 body: post_body_data(ACCESS_KEY_SECRET, sms_params))
      end

      # 原生参数拼接成请求字符串
      def query_string(params)
        qstring = ''
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
        params.each do |key, value|
          if cqstring.empty?
            cqstring += "#{encode(key)}=#{encode(value)}"
          else
            cqstring += "&#{encode(key)}=#{encode(value)}"
          end
        end
        return encode(cqstring)
      end

      def sign(key_secret, params)
        key = key_secret + '&'
        signature = 'POST' + '&' + encode('/') + '&' + canonicalized_query_string(params)
        sign = Base64.encode64("#{OpenSSL::HMAC.digest('sha1',key, signature)}")
        encode(sign.chomp)  # 通过chomp去掉最后的换行符 LF
      end

      def post_body_data(key_secret, params)
        body_data = 'Signature=' + sign(key_secret, params) + '&' + query_string(params)
      end

      def encode(input)
        output = url_encode(input)
      end

      def seed_timestamp
        Time.now.utc.strftime("%FT%TZ")
      end

      def seed_signature_nonce
        Time.now.utc.strftime("%Y%m%d%H%M%S%L")
      end
    end
  end
end
