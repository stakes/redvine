require 'redvine'
require 'spec_helper'

include Helpers

describe Redvine do

  describe '.connect' do

    it 'should create a new client' do
      expect(Redvine.new).to respond_to(:connect).with(1).argument
    end

    it 'should raise an error without a username and password' do
      client = Redvine.new
      expect { client.connect() }.to raise_error(ArgumentError)
    end
    
    it 'should connect and return a hash with a :vine_key' do
      config = get_config()
      client = Redvine.new
      client.connect(email: config['email'], password: config['password'])
      expect(client.vine_key).to be_an_instance_of(String)
    end

  end

  describe '.search' do

    it 'should respond to a search method' do
      client = setup_client()
      expect(client).to respond_to(:search)
    end

    it 'should throw an error without a hashtag' do
      client = setup_client()
      expect(client.search()).to raise_error(ArgumentError)
    end

    it 'should return a result when searching for a common keyword' do
      client = setup_client()
      vines = client.search('cat')
      expect(vines.count).to be > 1
      expect(vines.first.has_key?('videoUrl')).to be_true
      expect(vines.first.has_key?('avatarUrl')).to be_true
    end

  end

end