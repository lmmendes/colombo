# encoding: utf-8

require "colombo/size"

module Colombo
  class Sizes < Array

    def initialize(client)
      @client = client
      @client.request(:get, '/sizes/', {}) do |response|
         response['sizes'].each do |size|
            self << Size.new(@client, self, size)
         end
      end
    end

    def find(size_id)
      self.select{ |s| s.id == size_id }.first
    end

  end
end
