# encoding: utf-8

require File.expand_path('../test_helper.rb', __FILE__)

describe 'Event' do

  before do
    Colombo.reset

    Colombo.configure do |c|
      c.api_key   = ENV['DO_API_KEY']
      c.client_id = ENV['DO_CLIENT_ID']
    end

    @client = Colombo::Client.new
  end

  it 'find_event' do
    VCR.use_cassette('find_event') do
      @client.event(121222)
    end
  end

end
