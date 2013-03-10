# encoding: utf-8
module Colombo
  class Image

    attr_accessor :id, :name, :distribution

    def initialize(client, images, image_hash)
      @client   = client
      image_hash.each do |key, value|
        __send__("#{key}=", value) if self.respond_to?( key.to_sym )
      end
    end

    def destroy(confirm=false)
      return unless confirm
      @client.request(:get, "/images/#{self.id}/destroy/") do |response|
        return response['event_id']
      end
    end

  end
end
