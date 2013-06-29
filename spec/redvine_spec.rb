require 'redvine'
require 'spec_helper'
require 'vcr_setup'

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
      VCR.use_cassette('redvine') do
        config = get_config()
        client = Redvine.new
        client.connect(email: config['email'], password: config['password'])
        expect(client.vine_key).to be_an_instance_of(String)
      end
    end

  end

  describe '.search' do

    it 'should respond to a search method' do
      VCR.use_cassette('redvine') do
        client = setup_client()
        expect(client).to respond_to(:search)
      end
    end

    it 'should throw an error without a tag' do
      VCR.use_cassette('redvine') do
        client = setup_client()
        expect{ client.search() }.to raise_error(ArgumentError)
      end
    end

    it 'should return a result when searching for a common keyword' do
      VCR.use_cassette('redvine', :record => :new_episodes) do
        client = setup_client()
        vines = client.search('cat')
        expect(vines.count).to be > 1
        expect(vines.first.has_key?('videoUrl')).to be_true
        expect(vines.first.has_key?('avatarUrl')).to be_true
      end
    end

  end

  describe '.popular' do

    it 'should respond to a popular method' do
      expect(Redvine.new).to respond_to(:popular)
    end

    it 'should return a set of results with VideoUrls' do
      VCR.use_cassette('redvine', :record => :new_episodes) do
        client = setup_client()
        vines = client.popular
        expect(vines.count).to be > 1
        expect(vines.first.has_key?('videoUrl')).to be_true
      end
    end
    
  end


  describe '.promoted' do

    it 'should respond to a promoted method' do
      expect(Redvine.new).to respond_to(:promoted)
    end

    it 'should return a set of results with VideoUrls' do
      VCR.use_cassette('redvine', :record => :new_episodes) do
        client = setup_client()
        vines = client.promoted
        expect(vines.count).to be > 1
        expect(vines.first.has_key?('videoUrl')).to be_true
      end
    end

  end

  describe '.timeline' do

    it 'should respond to a timeline method' do
      expect(Redvine.new).to respond_to(:timeline)
    end

    it 'should return a set of results with VideoUrls'

  end

  describe '.user_profile' do

    it 'should respond to a user_profile method' do
      expect(Redvine.new).to respond_to(:user_profile)
    end

    it 'should throw an error without a user id' do
      client = Redvine.new
      expect { client.user_profile() }.to raise_error(ArgumentError)
    end

    it 'should return a user profile given a valid user id'

  end

  describe '.user_timeline' do

    it 'should respond to a user_timeline method' do
      expect(Redvine.new).to respond_to(:user_timeline)
    end

    it 'should throw an error without a user id' do
      client = Redvine.new
      expect { client.user_timeline() }.to raise_error(ArgumentError)
    end

    it 'should return a set of results with VideoUrls given a valid user id'

  end




end