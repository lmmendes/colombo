# encoding: utf-8

require "colombo/size"

module Colombo
  class Sizes < Container

    def initialize(client)
      @client = client
      @client.request(:get, '/sizes/', {}) do |response|
         response['sizes'].each do |size|
            self << Size.new(@client, size)
         end
      end
    end

  end
end
