require 'aliyun/sms'

def params_str(params)
  URI.encode_www_form(params.sort.to_h)
end

describe Aliyun::Sms do
  describe "#configure" do
    before do
      Aliyun::Sms.configure do |config|
        config.access_key_secret = 'testSecret'
        config.access_key_id = 'testId'
        config.action = 'SendSms'
        config.format = 'XML'
        config.region_id = 'cn-hangzhou'
        config.sign_name = '阿里云短信测试专用'
        config.signature_method = 'HMAC-SHA1'
        config.signature_version = '1.0'
        config.version = '2017-05-25'
      end
    end
  end

  describe "#params" do
    before do
      Aliyun::Sms.configure do |config|
        config.access_key_secret = 'testSecret'
        config.access_key_id = 'testId'
        config.action = 'SendSms'
        config.format = 'XML'
        config.region_id = 'cn-hangzhou'
        config.sign_name = '阿里云短信测试专用'
        config.signature_method = 'HMAC-SHA1'
        config.signature_version = '1.0'
        config.version = '2017-05-25'
      end
    end

    it "gets query params string by merge configed params and user params" do
      #config = Aliyun::Sms.configuration
      user_params = {
        'SignatureNonce' => '45e25e9b-0a6f-4070-8c85-2956eda1b466',
        'TemplateCode' => 'SMS_71390007',
        'Timestamp' => '2017-07-12T02:42:19Z',
        'PhoneNumbers' =>	'15300000001',
        'TemplateParam' => '{"customer":"test"}',
        'OutId'	=> '123'
      }

      expected = 'AccessKeyId=testId&Action=SendSms&Format=XML&OutId=123&PhoneNumbers=15300000001&RegionId=cn-hangzhou&SignName=%E9%98%BF%E9%87%8C%E4%BA%91%E7%9F%AD%E4%BF%A1%E6%B5%8B%E8%AF%95%E4%B8%93%E7%94%A8&Signature=zJDF%252BLrzhj%252FThnlvIToysFRq6t4%253D&SignatureMethod=HMAC-SHA1&SignatureNonce=45e25e9b-0a6f-4070-8c85-2956eda1b466&SignatureVersion=1.0&TemplateCode=SMS_71390007&TemplateParam=%7B%22customer%22%3A%22test%22%7D&Timestamp=2017-07-12T02%3A42%3A19Z&Version=2017-05-25'
      expect(params_str(Aliyun::Sms.get_params(user_params))).to eql(expected)
    end
  end

  it "signs" do
    params_input = {
      'AccessKeyId' => 'testId',
      'Action' => 'SendSms',
      'Format' => 'XML',
      'RegionId' => 'cn-hangzhou',
      'SignName' => '阿里云短信测试专用',
      'SignatureMethod' => 'HMAC-SHA1',
      'SignatureVersion' => '1.0',
      'Version' => '2017-05-25',
      'SignatureNonce' => '45e25e9b-0a6f-4070-8c85-2956eda1b466',
      'TemplateCode' => 'SMS_71390007',
      'Timestamp' => '2017-07-12T02:42:19Z',
      'PhoneNumbers' =>	'15300000001',
      'TemplateParam' => '{"customer":"test"}',
      'OutId'	=> '123'
    }
    key = 'testSecret'
    expected = 'zJDF%2BLrzhj%2FThnlvIToysFRq6t4%3D'

    expect(Aliyun::Sms.sign(key, params_input)).to eql(expected)
  end
end
