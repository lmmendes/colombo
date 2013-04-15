# encoding: utf-8

require "colombo/region"

module Colombo
  class Regions < Container

    def initialize(client)
      @client = client
      @client.request(:get, '/regions/', {}) do |response|
         response['regions'].each do |region|
            self[ region['id'].to_i ] = Region.new(@client, region)
         end
      end
    end

  end
end
