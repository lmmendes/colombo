# encoding: utf-8

require "colombo/image"

module Colombo
  class Images < Array

    def initialize(client)
      @client = client
      @client.request(:get, '/images/', {}) do |response|
         response['images'].each do |image|
            self << Image.new(@client, self, image)
         end
      end
    end

    def find(image_id)

      image = self.select{ |i| i.id == image_id }.first

      return image if not image.nil?

      response = @client.request(:get, "/images/#{image_id}") do |response|
        image = Image.new(@client, self, response['image'])
        self << image
      end

      return image
    end

  end
end
