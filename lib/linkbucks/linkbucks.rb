require 'net/http'
require 'net/https'
require 'json'

module Linkbucks
  # Unofficial API Wrapper for Linkbucks.com
  class API

    # Unique url API
    URL_API = 'https://www.linkbucks.com/api/createLink/single'

    # Valid content types
    CONTENT_TYPE = {clean: 1, adult: 2}

    # Valid ad types
    AD_TYPE = {intermission: 2, locker: 4, shortLink: 5}

    # Create instance to use API linkbucks
    #
    # If you want to get apiPassword see http://www.linkbucks.com/Profile
    #
    # @param user [String] Username
    # @param pass [String] API password
    def initialize user, pass
      @user, @pass = user, pass
    end

    # Create single link
    #
    # Maybe you want to see http://www.linkbucks.com/CreateLinks/Tools
    #
    # @param data [Hash] data to send api
    #
    # @option data [String] :originalLink Link to be converted
    # @option data [Symbol] :adType Type of advertisement {AD_TYPE See valid adTypes}
    # @option data [Symbol] :contenType Type of page content {CONTENT_TYPE See valid contentType}
    # @option data [String] :domain Alias domain to be used for ther generated link
    #
    # @example Simple use
    #   linkbucks.create_link_single(originalLink: 'http://www.google.es')['link']
    #
    # @return [Hash] Id and link
    #
    # @raise [AuthenticationFailed] user and apiPassword doesn't match
    # @raise [ValidationFailed] when supplied data didn't pass validation.
    # @raise [OperationFailed] Indicates processing error
    # @raise [ArgumentError] Invalid parameters
    # @raise [StandardError] Unknown error
    def create_link_single data
      data[:adType] = AD_TYPE[data[:adType]] if data[:adType].is_a? Symbol
      data[:contentType] = AD_TYPE[data[:contentType]] if data[:contentType].is_a? Symbol
      
      data = {contentType: CONTENT_TYPE[:clean], adType: AD_TYPE[:intermission], domain: 'linkbucks.com'}.merge(data)

      body = https_post URL_API, {user: @user, apiPassword: @pass}.merge(data)
      body = JSON.parse body  

      return body unless body.include? 'errorCode'

      case body['errorCode']
      when 1
        raise AuthenticationFailed, body['errorDescription']
      when 2
        raise ArgumentError, body['errorDescription']
      when 3
        raise ValidationFailed, body['errorDescription']
      when 4
        raise OperationFailed, body['errorDescription']
      else
        raise StandardError
      end
    end

    private
    def https_post url, data
      uri = URI.parse(url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Post.new(uri.path)
      req.body = data.to_json
      https.request(req).body
    end
  end
end