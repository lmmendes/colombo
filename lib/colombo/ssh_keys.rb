# encoding: utf-8

require "colombo/ssh_key"

module Colombo
  class SshKeys < Container

    def initialize(client)
      @client = client
      @client.request(:get, '/ssh_keys/', {}) do |response|
         response['ssh_keys'].each do |ssh_key|
            self << SshKey.new(@client, ssh_key)
         end
      end
    end

    def create(options={})

      params = {
        :ssh_pub_key => options[:ssh_pub_key],
        :name        => options[:name]
      }

      ssh_key = nil

      response = @client.request(:get, "/ssh_keys/new/", params) do |response|
        ssh_key = SshKey.new(@client, response['ssh_key'])
        self << ssh_key
      end

      ssh_key
    end

  end
end
