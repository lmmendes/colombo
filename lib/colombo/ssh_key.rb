# encoding: utf-8
module Colombo
  class SshKey

    attr_accessor :id, :name, :ssh_pub_key

    def initialize(client, ssh_keys, ssh_key_hash)
      @client   = client
      ssh_key_hash.each do |key, value|
        __send__("#{key}=", value) if self.respond_to?( key.to_sym )
      end
    end

    def destroy
      @client.request(:get, "/ssh_keys/#{self.id}/destroy/") do |response|
        return true
      end
      return false
    end

    def update(options={})
      params = {
        :ssh_pub_key => options[:ssh_pub_key]
      }
      response = @client.request(:get, "/ssh_keys/#{self.id}/edit/", params) do |response|
        return true
      end
      return false
    end

  end
end
