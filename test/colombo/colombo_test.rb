# encoding: utf-8

require File.expand_path('../test_helper.rb', __FILE__)

describe 'Colombo' do

  before do

    Colombo.reset

    Colombo.configure do |c|
      c.api_key   = ENV['DO_API_KEY']
      c.client_id = ENV['DO_CLIENT_ID']
    end

  end

  it 'should have a version' do
    Colombo::VERSION.wont_be_nil
  end

end
