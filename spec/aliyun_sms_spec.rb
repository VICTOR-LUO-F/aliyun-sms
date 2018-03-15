require 'aliyun/sms'
describe Aliyun::Sms do

  describe "#top test" do
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

    it "get the http query url" do
      user_params = {
        'SignatureNonce' => '45e25e9b-0a6f-4070-8c85-2956eda1b466',
        'TemplateCode' => 'SMS_71390007',
        'Timestamp' => '2017-07-12T02:42:19Z',
        'PhoneNumbers' =>	'15300000001',
        'TemplateParam' => '{"customer":"test"}',
        'OutId'	=> '123'
      }
      spect_output = 'http://dysmsapi.aliyuncs.com/?Signature=zJDF%2BLrzhj%2FThnlvIToysFRq6t4%3D&AccessKeyId=testId&Action=SendSms&Format=XML&OutId=123&PhoneNumbers=15300000001&RegionId=cn-hangzhou&SignName=%E9%98%BF%E9%87%8C%E4%BA%91%E7%9F%AD%E4%BF%A1%E6%B5%8B%E8%AF%95%E4%B8%93%E7%94%A8&SignatureMethod=HMAC-SHA1&SignatureNonce=45e25e9b-0a6f-4070-8c85-2956eda1b466&SignatureVersion=1.0&TemplateCode=SMS_71390007&TemplateParam=%7B%22customer%22%3A%22test%22%7D&Timestamp=2017-07-12T02%3A42%3A19Z&Version=2017-05-25'
      expect(Aliyun::Sms.get_url(user_params)).to eql(spect_output)
    end
  end

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

    it "get query string through configurated itmes" do
      config = Aliyun::Sms.configuration
      method_input = {
        'AccessKeyId' => config.access_key_id,
        'Action' => config.action,
        'Format' => config.format,
        'RegionId' => config.region_id,
        'SignName' => config.sign_name,
        'SignatureMethod' => config.signature_method,
        'SignatureVersion' => config.signature_version,
        'Version' => config.version,
        'SignatureNonce' => '45e25e9b-0a6f-4070-8c85-2956eda1b466',
        'TemplateCode' => 'SMS_71390007',
        'Timestamp' => '2017-07-12T02:42:19Z',
        'PhoneNumbers' =>	'15300000001',
        'TemplateParam' => '{"customer":"test"}',
        'OutId'	=> '123'
      }
      spect_output = 'AccessKeyId=testId&Action=SendSms&Format=XML&OutId=123&PhoneNumbers=15300000001&RegionId=cn-hangzhou&SignName=阿里云短信测试专用&SignatureMethod=HMAC-SHA1&SignatureNonce=45e25e9b-0a6f-4070-8c85-2956eda1b466&SignatureVersion=1.0&TemplateCode=SMS_71390007&TemplateParam={"customer":"test"}&Timestamp=2017-07-12T02:42:19Z&Version=2017-05-25'

      expect(Aliyun::Sms.test_query_string(method_input)).to eql(spect_output)
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

    it "get query params string by merge configed params and user params" do
      #config = Aliyun::Sms.configuration
      user_params = {
        'SignatureNonce' => '45e25e9b-0a6f-4070-8c85-2956eda1b466',
        'TemplateCode' => 'SMS_71390007',
        'Timestamp' => '2017-07-12T02:42:19Z',
        'PhoneNumbers' =>	'15300000001',
        'TemplateParam' => '{"customer":"test"}',
        'OutId'	=> '123'
      }

      spect_output = 'AccessKeyId=testId&Action=SendSms&Format=XML&OutId=123&PhoneNumbers=15300000001&RegionId=cn-hangzhou&SignName=阿里云短信测试专用&SignatureMethod=HMAC-SHA1&SignatureNonce=45e25e9b-0a6f-4070-8c85-2956eda1b466&SignatureVersion=1.0&TemplateCode=SMS_71390007&TemplateParam={"customer":"test"}&Timestamp=2017-07-12T02:42:19Z&Version=2017-05-25'
      get_params = Aliyun::Sms.get_params(user_params)
      expect(Aliyun::Sms.test_query_string(get_params)).to eql(spect_output)
    end
  end

  it "get the canonicalized query string" do
    method_input = {
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

    spect_output = 'AccessKeyId=testId&Action=SendSms&Format=XML&OutId=123&PhoneNumbers=15300000001&RegionId=cn-hangzhou&SignName=%E9%98%BF%E9%87%8C%E4%BA%91%E7%9F%AD%E4%BF%A1%E6%B5%8B%E8%AF%95%E4%B8%93%E7%94%A8&SignatureMethod=HMAC-SHA1&SignatureNonce=45e25e9b-0a6f-4070-8c85-2956eda1b466&SignatureVersion=1.0&TemplateCode=SMS_71390007&TemplateParam=%7B%22customer%22%3A%22test%22%7D&Timestamp=2017-07-12T02%3A42%3A19Z&Version=2017-05-25'

    expect(Aliyun::Sms.canonicalized_query_string(method_input)).to eql(spect_output)
  end

  it "get sign" do
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
    spect_output = 'zJDF%2BLrzhj%2FThnlvIToysFRq6t4%3D'
    coded_params = 'AccessKeyId=testId&Action=SendSms&Format=XML&OutId=123&PhoneNumbers=15300000001&RegionId=cn-hangzhou&SignName=%E9%98%BF%E9%87%8C%E4%BA%91%E7%9F%AD%E4%BF%A1%E6%B5%8B%E8%AF%95%E4%B8%93%E7%94%A8&SignatureMethod=HMAC-SHA1&SignatureNonce=45e25e9b-0a6f-4070-8c85-2956eda1b466&SignatureVersion=1.0&TemplateCode=SMS_71390007&TemplateParam=%7B%22customer%22%3A%22test%22%7D&Timestamp=2017-07-12T02%3A42%3A19Z&Version=2017-05-25'

    expect(Aliyun::Sms.sign(key, coded_params)).to eql(spect_output)
  end

end
