# encoding: utf-8

require File.expand_path('../test_helper.rb', __FILE__)

def self.test_order
  :alpha
end

describe 'Droplets' do

  before do
    Colombo.reset

    Colombo.configure do |c|
      c.api_key   = ENV['DO_API_KEY']
      c.client_id = ENV['DO_CLIENT_ID']
    end

    @do = Colombo.new

  end


  it 'list droplets' do
    VCR.use_cassette('droplets') do
      @do.droplets.must_be_instance_of(Colombo::Droplets)
    end
  end

  it 'create columbus droplet' do
    VCR.use_cassette('create_droplet') do
      @do.droplets.create({
        :name       => COLOMBO_DROPLET_NAME  ,
        :image_id   => COLOMBO_IMAGE_ID      ,
        :region_id  => COLOMBO_REGION_ID     ,
        :size_id    => COLOMBO_SIZE_ID
      })
    end
  end

  it 'find droplet' do
    VCR.use_cassette('droplets_find') do
      # Colombo.new.droplets.find(1)
    end
  end

end
