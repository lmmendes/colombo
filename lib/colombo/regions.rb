# encoding: utf-8

require "colombo/region"

module Colombo
  class Regions < Array

    def initialize(client)
      @client = client
      @client.request(:get, '/regions/', {}) do |response|
         response['regions'].each do |region|
            self[ region['id'].to_i ] = Region.new(@client, self, region)
         end
      end
    end

    def find(region_id)

      region = self.select{ |r| r.id == region_id }.first

      return region if not region.nil?

      response = @client.request(:get, "/regions/#{region_id}") do |response|
        region = Region.new(@client, self, response['region'])
        self << region
      end

      return region
    end

  end
end
