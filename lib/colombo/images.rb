# encoding: utf-8

require "colombo/image"

module Colombo
  class Images < Container

    def initialize(client, options)
      @client = client
      @client.request(:get, '/images/', options) do |response|
         response['images'].each do |image|
            self << Image.new(@client, image)
         end
      end
    end

  end
end
