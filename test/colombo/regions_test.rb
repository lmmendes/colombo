# encoding: utf-8

require File.expand_path('../test_helper.rb', __FILE__)

describe 'Regions' do

  before do
    Colombo.reset

    Colombo.configure do |c|
      c.api_key   = ENV['DO_API_KEY']
      c.client_id = ENV['DO_CLIENT_ID']
    end

    @client = Colombo::Client.new
  end

  it 'regions' do
    VCR.use_cassette('regions') do
      @client.regions.wont_be_empty
      # puts "== REGIONS ==="
      # puts @client.regions.inspect
    end
  end


end
