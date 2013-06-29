require 'httparty'
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
    response = HTTParty.get(@@baseUrl + 'timelines/tags/' + tag, {headers: session_headers})
    response.parsed_response['data']['records']
  end

  def popular
    response = HTTParty.get(@@baseUrl + 'timelines/popular', {headers: session_headers})
    response.parsed_response['data']['records']
  end

  def promoted
    response = HTTParty.get(@@baseUrl + 'timelines/promoted', {headers: session_headers})
    response.parsed_response['data']['records']
  end

  def timeline
    response = HTTParty.get(@@baseUrl + 'timelines/graph', {headers: session_headers})
    response.parsed_response['data']['records']
  end

  def user_profile(uid)
    raise(ArgumentError, 'You must specify a user id') if !uid
  end

  def user_timeline(uid)
    raise(ArgumentError, 'You must specify a user id') if !uid
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

end

