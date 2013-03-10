# encoding: utf-8

require File.expand_path('../test_helper.rb', __FILE__)

def self.test_order
  :alpha
end

describe 'SshKeys' do

  before do
    Colombo.reset

    Colombo.configure do |c|
      c.api_key   = ENV['DO_API_KEY']
      c.client_id = ENV['DO_CLIENT_ID']
    end

    @client = Colombo::Client.new
  end

  it 'list ssh keys' do

    VCR.use_cassette('ssh_keys') do
      @client.ssh_keys.wont_be_nil
    end

  end

  it 'add ssh key' do

    VCR.use_cassette('add ssh key') do

      ssh_key = @client.ssh_keys.create({
        :name        => COLOMBO_SSH_KEY_NAME,
        :ssh_pub_key => COLOMBO_SSH_KEY
      })

      ssh_key.must_be_instance_of(Colombo::SshKey)

      ssh_key.name.must_equal COLOMBO_SSH_KEY_NAME

      ssh_key.ssh_pub_key.must_equal COLOMBO_SSH_KEY
    end

  end

  it 'find ssh key by id' do

    VCR.use_cassette('find ssh keys by id') do

      # fetch the key list from digital ocean
      ssh_keys = @client.ssh_keys

      # find the key with COLOMBO_SSH_KEY_NAME inside the digital ocean colection
      do_key  = ssh_keys.select{ |k| k.name==COLOMBO_SSH_KEY_NAME }.first

      # check if the key was found
      do_key.must_be_instance_of(Colombo::SshKey)

      # let's try find the key in the collection
      ssh_key = @client.ssh_keys.find( do_key.id )

      # check if it's a ssh_key
      ssh_key.must_be_instance_of(Colombo::SshKey)

      # check if the values are correct
      ssh_key.name.must_equal COLOMBO_SSH_KEY_NAME

      # check if the values are correct
      ssh_key.ssh_pub_key.must_equal COLOMBO_SSH_KEY

    end

  end

  it 'update key' do

    VCR.use_cassette('update key') do
      # fetch the key list from digital ocean
      ssh_keys = @client.ssh_keys

      # find the key with COLOMBO_SSH_KEY_NAME inside the digital ocean colection
      do_key  = ssh_keys.select{ |k| k.name==COLOMBO_SSH_KEY_NAME }.first

      # check if the key was found and is a SshKey
      do_key.must_be_instance_of(Colombo::SshKey)

      do_key.update(:ssh_pub_key => COLOMBO_SSH_KEY ).must_equal true
    end

  end

  it 'destroy ssh key' do
    VCR.use_cassette('destory ssh key') do
      # fetch the key list from digital ocean
      ssh_keys = @client.ssh_keys

      # find the key with COLOMBO_SSH_KEY_NAME inside the digital ocean colection
      ssh_keys.each do |ssh_key|
        if ssh_key.name==COLOMBO_SSH_KEY_NAME
          ssh_key.destroy().must_equal true
        end
      end

    end

    VCR.use_cassette('are all keys destroyed?') do
      @client.ssh_keys.select{ |key| key.name == COLOMBO_SSH_KEY_NAME }.must_be_empty
    end


  end

end
