# encoding: utf-8

require "colombo/image"

module Colombo
  class Images < Container

    def initialize(client)
      @client = client
      @client.request(:get, '/images/', {}) do |response|
         response['images'].each do |image|
            self << Image.new(@client, image)
         end
      end
    end

  end
end
