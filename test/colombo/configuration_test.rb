# encoding: utf-8

require File.expand_path('../test_helper.rb', __FILE__)

describe 'configuration' do

  before do
    Colombo.reset
  end

  describe '.api_key' do
    it '.api_key should be equal to default' do
      Colombo.api_key.must_equal Colombo::Configuration::DEFAULT_API_KEY
    end
  end

  describe '.client_id' do
    it '.client_id should be equal to default' do
      Colombo.client_id.must_equal Colombo::Configuration::DEFAULT_CLIENT_ID
    end
  end

  describe '.user_agent' do
    it '.user_agent should be equal to default' do
      Colombo.user_agent.must_equal Colombo::Configuration::DEFAULT_USER_AGENT
    end
  end

  after do
    Colombo.reset
  end

  describe '.configuration' do
    Colombo::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "should set #{key}" do
        Colombo.configure do |config|
          config.send("#{key}=", key.to_s)
          Colombo.send("#{key}").must_equal key.to_s
        end
      end
    end
  end

end
