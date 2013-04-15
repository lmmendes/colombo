# encoding: utf-8

require File.expand_path('../test_helper.rb', __FILE__)

describe Colombo::SshKeys do

  i_suck_and_my_tests_are_order_dependent!

  before do
  Colombo.reset
    Colombo.configure do |c|
      c.api_key   = ENV['DO_API_KEY']
      c.client_id = ENV['DO_CLIENT_ID']
    end
    @client = Colombo::Client.new
  end

  it 'add key' do
    $stdout.puts "1 - add key"
    VCR.use_cassette('sshkeys-add_key') do

      ssh_key = @client.ssh_keys.create({
        :name        => COLOMBO_SSH_KEY_NAME,
        :ssh_pub_key => COLOMBO_SSH_KEY
      })

      ssh_key.must_be_instance_of(Colombo::SshKey)
      ssh_key.name.must_equal COLOMBO_SSH_KEY_NAME
      ssh_key.ssh_pub_key.must_equal COLOMBO_SSH_KEY
    end
  end

  it 'list ssh keys' do
    $stdout.puts "2 - list ssh keys"
    VCR.use_cassette('sshkeys-list_keys') do
      @client.ssh_keys.wont_be_empty
    end
  end

  it 'find ssh key by id' do

    $stdout.puts "3 - find ssh key by id"

    VCR.use_cassette('sshkeys-find_ssh_keys_by_id') do

      # fetch the key list from digital ocean
      ssh_keys = @client.ssh_keys

      # find the key with COLOMBO_SSH_KEY_NAME inside the digital ocean colection
      do_key  = ssh_keys.select{ |key| key.name == COLOMBO_SSH_KEY_NAME }.first

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

  it 'find by name' do
    $stdout.puts "4 - find by name"

    VCR.use_cassette('sshkeys-find_by_name') do
      p @client.ssh_keys
      ssh_key = @client.ssh_keys.find_by_name( COLOMBO_SSH_KEY_NAME )
      ssh_key.must_be_instance_of(Colombo::SshKey)
    end

  end

  it 'update key' do

    $stdout.puts "5 - update key"

    VCR.use_cassette('sshkeys_update_key') do
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

    $stdout.puts "6 - destroy ssh key"

    VCR.use_cassette('sshkeys_destroy_ssh_key') do
      # fetch the key list from digital ocean
      ssh_keys = @client.ssh_keys

      # find the key with COLOMBO_SSH_KEY_NAME inside the digital ocean colection
      ssh_keys.each do |ssh_key|
        if ssh_key.name==COLOMBO_SSH_KEY_NAME
          ssh_key.destroy().must_equal true
        end
      end

    end

  end


end

#   it 'add key' do

#     $stdout.puts "1 - sshkeys_add_key"

#     VCR.use_cassette('sskkeys_add_ssh_key') do

#       ssh_key = @client.ssh_keys.create({
#         :name        => COLOMBO_SSH_KEY_NAME,
#         :ssh_pub_key => COLOMBO_SSH_KEY
#       })

#       ssh_key.must_be_instance_of(Colombo::SshKey)

#       ssh_key.name.must_equal COLOMBO_SSH_KEY_NAME

#       ssh_key.ssh_pub_key.must_equal COLOMBO_SSH_KEY
#     end

#   end

#   it 'list ssh keys' do

#     $stdout.puts "2 - list ssh keys"

#     VCR.use_cassette('sshkeys_list_keys') do
#       @client.ssh_keys.wont_be_empty
#     end

#   end


#   it 'find ssh key by id' do

#     $stdout.puts "3 - find ssh key by id"

#     VCR.use_cassette('sshkeys_find_ssh_keys_by_id') do

#       # fetch the key list from digital ocean
#       ssh_keys = @client.ssh_keys

#       $stdout.puts "============ keys ========="
#       $stdout.puts ssh_keys.inspect


#       # find the key with COLOMBO_SSH_KEY_NAME inside the digital ocean colection
#       do_key  = ssh_keys.find_by_name(COLOMBO_SSH_KEY_NAME)
#       $stdout.puts "============ find by name ========="
#       $stdout.puts do_key

#       # check if the key was found
#       do_key.must_be_instance_of(Colombo::SshKey)

#       # let's try find the key in the collection
#       ssh_key = @client.ssh_keys.find( do_key.id )

#       # check if it's a ssh_key
#       ssh_key.must_be_instance_of(Colombo::SshKey)

#       # check if the values are correct
#       ssh_key.name.must_equal COLOMBO_SSH_KEY_NAME

#       # check if the values are correct
#       ssh_key.ssh_pub_key.must_equal COLOMBO_SSH_KEY

#     end

#   end

#   it 'update key' do

#     $stdout.puts "4 - update key"

#     VCR.use_cassette('sshkeys_update_key') do
#       # fetch the key list from digital ocean
#       ssh_keys = @client.ssh_keys

#       # find the key with COLOMBO_SSH_KEY_NAME inside the digital ocean colection
#       do_key  = ssh_keys.select{ |k| k.name==COLOMBO_SSH_KEY_NAME }.first

#       # check if the key was found and is a SshKey
#       do_key.must_be_instance_of(Colombo::SshKey)

#       do_key.update(:ssh_pub_key => COLOMBO_SSH_KEY ).must_equal true
#     end

#   end

#   it 'destroy ssh key' do

#     $stdout.puts "5 - destroy ssh key"

#     VCR.use_cassette('sshkeys_destory_ssh_key') do
#       # fetch the key list from digital ocean
#       ssh_keys = @client.ssh_keys

#       # find the key with COLOMBO_SSH_KEY_NAME inside the digital ocean colection
#       ssh_keys.each do |ssh_key|
#         if ssh_key.name==COLOMBO_SSH_KEY_NAME
#           ssh_key.destroy().must_equal true
#         end
#       end

#     end

#     VCR.use_cassette('sshkeys_are_dummy_keys_destroyed?') do
#       @client.ssh_keys.select{ |key| key.name == COLOMBO_SSH_KEY_NAME }.must_be_empty
#     end

#   end


# end
