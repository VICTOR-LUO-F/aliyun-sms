require 'aliyun/sms'
describe Aliyun::Sms do

  describe "#configure" do
    before do
      Aliyun::Sms.configure do |config|
        config.access_key_secret = 'testsecret'
        config.access_key_id = 'testid'
        config.action = 'SingleSendSms'
        config.format = 'XML'
        config.region_id = 'cn-hangzhou'
        config.sign_name = '标签测试'
        config.signature_method = 'HMAC-SHA1'
        config.signature_version = '1.0'
        config.sms_version = '2016-09-27'
      end
    end

    it "get canonicalized query string through configurated itmes" do
      config = Aliyun::Sms.configuration
      method_input = {
        'AccessKeyId' => config.access_key_id,
        'Action' => config.action,
        'Format' => config.format,
        'ParamString' => '{"name":"d","name1":"d"}',
        'RecNum' => '13098765432',
        'RegionId' => config.region_id,
        'SignName' => config.sign_name,
        'SignatureMethod' => config.signature_method,
        'SignatureNonce' => '9e030f6b-03a2-40f0-a6ba-157d44532fd0',
        'SignatureVersion' => config.signature_version,
        'TemplateCode' => 'SMS_1650053',
        'Timestamp' => '2016-10-20T05:37:52Z',
        'Version' => config.sms_version,
        }

      spect_output = 'AccessKeyId=testid&Action=SingleSendSms&Format=XML&ParamString=%7B%22name%22%3A%22d%22%2C%22name1%22%3A%22d%22%7D&RecNum=13098765432&RegionId=cn-hangzhou&SignName=%E6%A0%87%E7%AD%BE%E6%B5%8B%E8%AF%95&SignatureMethod=HMAC-SHA1&SignatureNonce=9e030f6b-03a2-40f0-a6ba-157d44532fd0&SignatureVersion=1.0&TemplateCode=SMS_1650053&Timestamp=2016-10-20T05%3A37%3A52Z&Version=2016-09-27'

      expect(Aliyun::Sms.canonicalized_query_string(method_input)).to eql(spect_output)
    end
  end

  it "get the canonicalized query string" do
    method_input = {
        'AccessKeyId' => 'testid',
        'Action' => 'SingleSendSms',
        'Format' => 'XML',
        'ParamString' => '{"name":"d","name1":"d"}',
        'RecNum' => '13098765432',
        'RegionId' => 'cn-hangzhou',
        'SignName' => '标签测试',
        'SignatureMethod' => 'HMAC-SHA1',
        'SignatureNonce' => '9e030f6b-03a2-40f0-a6ba-157d44532fd0',
        'SignatureVersion' => '1.0',
        'TemplateCode' => 'SMS_1650053',
        'Timestamp' => '2016-10-20T05:37:52Z',
        'Version' => '2016-09-27',
      }
    spect_output = 'AccessKeyId=testid&Action=SingleSendSms&Format=XML&ParamString=%7B%22name%22%3A%22d%22%2C%22name1%22%3A%22d%22%7D&RecNum=13098765432&RegionId=cn-hangzhou&SignName=%E6%A0%87%E7%AD%BE%E6%B5%8B%E8%AF%95&SignatureMethod=HMAC-SHA1&SignatureNonce=9e030f6b-03a2-40f0-a6ba-157d44532fd0&SignatureVersion=1.0&TemplateCode=SMS_1650053&Timestamp=2016-10-20T05%3A37%3A52Z&Version=2016-09-27'

    expect(Aliyun::Sms.canonicalized_query_string(method_input)).to eql(spect_output)
  end

  it "get sign" do
    params_input = {
        'AccessKeyId' => 'testid',
        'Action' => 'SingleSendSms',
        'Format' => 'XML',
        'ParamString' => '{"name":"d","name1":"d"}',
        'RecNum' => '13098765432',
        'RegionId' => 'cn-hangzhou',
        'SignName' => '标签测试',
        'SignatureMethod' => 'HMAC-SHA1',
        'SignatureNonce' => '9e030f6b-03a2-40f0-a6ba-157d44532fd0',
        'SignatureVersion' => '1.0',
        'TemplateCode' => 'SMS_1650053',
        'Timestamp' => '2016-10-20T05:37:52Z',
        'Version' => '2016-09-27',
      }
    key = 'testsecret'

    spect_output = 'Q%2Bo73umDvTisJJyv3wqCsF0RHK4%3D'

    expect(Aliyun::Sms.sign(key, params_input)).to eql(spect_output)
  end

  it "get get query params" do
    params_input = {
        'AccessKeyId' => 'testid',
        'Action' => 'SingleSendSms',
        'Format' => 'XML',
        'ParamString' => '{"name":"d","name1":"d"}',
        'RecNum' => '13098765432',
        'RegionId' => 'cn-hangzhou',
        'SignName' => '标签测试',
        'SignatureMethod' => 'HMAC-SHA1',
        'SignatureNonce' => '9e030f6b-03a2-40f0-a6ba-157d44532fd0',
        'SignatureVersion' => '1.0',
        'TemplateCode' => 'SMS_1650053',
        'Timestamp' => '2016-10-20T05:37:52Z',
        'Version' => '2016-09-27',
      }
    key = 'testsecret'

    spect_output = 'Signature=Q%2Bo73umDvTisJJyv3wqCsF0RHK4%3D&AccessKeyId=testid&Action=SingleSendSms&Format=XML&ParamString=%7B%22name%22%3A%22d%22%2C%22name1%22%3A%22d%22%7D&RecNum=13098765432&RegionId=cn-hangzhou&SignName=%E6%A0%87%E7%AD%BE%E6%B5%8B%E8%AF%95&SignatureMethod=HMAC-SHA1&SignatureNonce=9e030f6b-03a2-40f0-a6ba-157d44532fd0&SignatureVersion=1.0&TemplateCode=SMS_1650053&Timestamp=2016-10-20T05%3A37%3A52Z&Version=2016-09-27'

    expect(Aliyun::Sms.get_query_params(key, params_input)).to eql(spect_output)
  end

end
