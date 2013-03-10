# encoding: utf-8

require File.expand_path('../test_helper.rb', __FILE__)

describe 'Images' do

  before do
    Colombo.reset

    Colombo.configure do |c|
      c.api_key   = ENV['DO_API_KEY']
      c.client_id = ENV['DO_CLIENT_ID']
    end

    @client = Colombo::Client.new
  end

  it 'images' do
    VCR.use_cassette('images') do
      @client.images.wont_be_empty
    end
  end


  it 'find image via find method' do
    VCR.use_cassette('images') do
      @client.images.find(COLOMBO_IMAGE_ID).wont_be_nil
    end
  end

  it 'find image via [] operator' do
    VCR.use_cassette('images') do
      @client.images.find(COLOMBO_IMAGE_ID).wont_be_nil
    end
  end

end
