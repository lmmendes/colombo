# encoding: utf-8

module Colombo
  class SshKey < Resource

    attr_accessor :id, :name, :ssh_pub_key

    def destroy
      @client.request(:get, "/ssh_keys/#{self.id}/destroy/") do |response|
        return true
      end
      return false
    end

    def ssh_pub_key
      return unless self.id
      return @ssh_pub_key if @ssh_pub_key
      @client.request(:get, "/ssh_keys/#{self.id}/") do |response|
        @ssh_pub_key = response['ssh_key']['ssh_pub_key']
      end
      @ssh_pub_key
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
