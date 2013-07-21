require 'httparty'
require 'hashie'
require 'redvine/version'

class Redvine

  attr_reader :vine_key, :username, :user_id

  @@baseUrl = 'https://api.vineapp.com/'
  @@deviceToken = 'Redvine'
  @@userAgent = 'com.vine.iphone/1.01 (unknown, iPhone OS 6.0, iPad, Scale/2.000000) (Redvine)'

  def connect(opts={})
    validate_connect_args(opts)
    query = {username: opts[:email], password: opts[:password], deviceToken: @@deviceToken}
    headers = {'User-Agent' => @@userAgent}
    response = HTTParty.post(@@baseUrl + 'users/authenticate', {body: query, headers: headers})
    @vine_key = response.parsed_response['data']['key']
    @username = response.parsed_response['data']['username']
    @user_id = response.parsed_response['data']['userId']
  end

  def search(tag)
    raise(ArgumentError, 'You must specify a tag') if !tag
    get_request_data('timelines/tags/' + tag)
  end

  def popular
    get_request_data('timelines/popular')
  end

  def promoted
    get_request_data('timelines/promoted')
  end

  def timeline
    get_request_data('timelines/graph')
  end

  def user_profile(uid)
    raise(ArgumentError, 'You must specify a user id') if !uid
    get_request_data('users/profiles/' + uid, false)
  end

  def user_timeline(uid)
    raise(ArgumentError, 'You must specify a user id') if !uid
    get_request_data('timelines/users/' + uid)
  end


  private
  def validate_connect_args(opts={})
    unless opts.has_key?(:email) and opts.has_key?(:email)
      raise(ArgumentError, 'You must specify both :email and :password')
    end
  end

  def session_headers
    {'User-Agent' => @@userAgent, 'vine-session-id' => @vine_key}
  end

  def get_request_data(endpoint, records=true)
    response = HTTParty.get(@@baseUrl + endpoint, {headers: session_headers})
    if response.parsed_response['success'] == false
      return Hashie::Mash.new(response.parsed_response)
    else
      records ? Hashie::Mash.new(response.parsed_response).data.records : Hashie::Mash.new(response.parsed_response).data
    end
  end

end

