# encoding: utf-8

require "colombo/ssh_key"

module Colombo
  class SshKeys < Array

    def initialize(client)
      @client = client
      @client.request(:get, '/ssh_keys/', {}) do |response|
         response['ssh_keys'].each do |ssh_key|
            self << SshKey.new(@client, self, ssh_key)
         end
      end
    end

    def find(ssh_key_id)
      ssh_key  = self.select{ |o| o == ssh_key_id }.first

      return ssh_key if ssh_key

      response = @client.request(:get, "/ssh_keys/#{ssh_key_id}") do |response|
        ssh_key = SshKey.new(@client, self, response['ssh_key'])
        self << ssh_key
      end

      return ssh_key
    end

    def create(options={})

      params = {
        :ssh_pub_key => options[:ssh_pub_key],
        :name        => options[:name]
      }

      ssh_key = nil

      response = @client.request(:get, "/ssh_keys/new/", params) do |response|
        ssh_key = SshKey.new(@client, self, response['ssh_key'])
        self << ssh_key
      end

      ssh_key
    end

  end
end
