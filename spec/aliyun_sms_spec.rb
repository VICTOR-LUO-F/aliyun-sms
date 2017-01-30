require 'aliyun/sms'
describe Aliyun::Sms do


  it "get the query string" do
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
    spect_output = 'AccessKeyId=testid&Action=SingleSendSms&Format=XML&ParamString={"name":"d","name1":"d"}&RecNum=13098765432&RegionId=cn-hangzhou&SignName=标签测试&SignatureMethod=HMAC-SHA1&SignatureNonce=9e030f6b-03a2-40f0-a6ba-157d44532fd0&SignatureVersion=1.0&TemplateCode=SMS_1650053&Timestamp=2016-10-20T05:37:52Z&Version=2016-09-27'

    expect(Aliyun::Sms.query_string(method_input)).to eql(spect_output)
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
    spect_output = 'AccessKeyId%3Dtestid%26Action%3DSingleSendSms%26Format%3DXML%26ParamString%3D%257B%2522name%2522%253A%2522d%2522%252C%2522name1%2522%253A%2522d%2522%257D%26RecNum%3D13098765432%26RegionId%3Dcn-hangzhou%26SignName%3D%25E6%25A0%2587%25E7%25AD%25BE%25E6%25B5%258B%25E8%25AF%2595%26SignatureMethod%3DHMAC-SHA1%26SignatureNonce%3D9e030f6b-03a2-40f0-a6ba-157d44532fd0%26SignatureVersion%3D1.0%26TemplateCode%3DSMS_1650053%26Timestamp%3D2016-10-20T05%253A37%253A52Z%26Version%3D2016-09-27'

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

    spect_output = 'ka8PDlV7S9sYqxEMRnmlBv%2FDoAE%3D'

    expect(Aliyun::Sms.sign(key, params_input)).to eql(spect_output)
  end

  it "get post body data" do
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

    spect_output = 'Signature=ka8PDlV7S9sYqxEMRnmlBv%2FDoAE%3D&AccessKeyId=testid&Action=SingleSendSms&Format=XML&ParamString={"name":"d","name1":"d"}&RecNum=13098765432&RegionId=cn-hangzhou&SignName=标签测试&SignatureMethod=HMAC-SHA1&SignatureNonce=9e030f6b-03a2-40f0-a6ba-157d44532fd0&SignatureVersion=1.0&TemplateCode=SMS_1650053&Timestamp=2016-10-20T05:37:52Z&Version=2016-09-27'

    expect(Aliyun::Sms.post_body_data(key, params_input)).to eql(spect_output)
  end

end
