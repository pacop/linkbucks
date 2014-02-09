require 'rspec'
require 'webmock'
require 'webmock/rspec'

VALID_USER = 'pacop'
VALID_PASS = '1234'
VALID_LINK_ID = 546
VALID_LINK = 'http://linkbucks.com/asd'

INVALID_PASS = 'invalid'


WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do

      stub_request(:post, "https://www.linkbucks.com/api/createLink/single").
         with(:body => "{\"user\":\"#{VALID_USER}\",\"apiPassword\":\"#{VALID_PASS}\",\"contentType\":1,\"adType\":2,\"domain\":\"linkbucks.com\",\"originalLink\":\"http://www.google.es\"}",
              :headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "{\"linkId\": #{VALID_LINK_ID}, \"link\":\"#{VALID_LINK}\"}", :headers => {})
      
      stub_request(:post, "https://www.linkbucks.com/api/createLink/single").
         with(:body => "{\"user\":\"#{VALID_USER}\",\"apiPassword\":\"#{INVALID_PASS}\",\"contentType\":1,\"adType\":2,\"domain\":\"linkbucks.com\",\"originalLink\":\"http://www.google.es\"}",
              :headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => '{"errorCode":1, "errorDescription":"Here message"}', :headers => {})

      stub_request(:post, "https://www.linkbucks.com/api/createLink/single").
         with(:body => "{\"user\":\"#{VALID_USER}\",\"apiPassword\":\"#{VALID_PASS}\",\"contentType\":1,\"adType\":\"invalid\",\"domain\":\"linkbucks.com\",\"originalLink\":\"http://www.google.es\"}",
              :headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => '{"errorCode":2, "errorDescription":"Here message"}', :headers => {})

      stub_request(:post, "https://www.linkbucks.com/api/createLink/single").
         with(:body => "{\"user\":\"pacop\",\"apiPassword\":\"1234\",\"contentType\":1,\"adType\":2,\"domain\":\"linkbucks.com\",\"originalLink\":\"google.es\"}",
              :headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body =>'{"errorCode":3, "errorDescription":"Here message"}', :headers => {})
      
      # Here we assume that API has operation failed with this (valid)input
      stub_request(:post, "https://www.linkbucks.com/api/createLink/single").
         with(:body => "{\"user\":\"pacop\",\"apiPassword\":\"1234\",\"contentType\":\"operationFailed\",\"adType\":2,\"domain\":\"linkbucks.com\",\"originalLink\":\"http://www.google.es\"}",
              :headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body =>'{"errorCode":4, "errorDescription":"Here message"}', :headers => {})


  end
end


