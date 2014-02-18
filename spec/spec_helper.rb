require 'debugger'

module Helpers
  def setup_client
    config = get_config()
    client = Redvine.new
    VCR.use_cassette('redvine_auth') do
      client.connect(email: config['email'], password: config['password'])
    end
    client
  end

  def get_config
    raw_config = File.read('config.yml')
    config = YAML.load(raw_config)
  end
end