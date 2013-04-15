# encoding: utf-8

require "colombo/droplet"

module Colombo
  class Droplets < Container

    def initialize(client)
      @client = client
      @client.request(:get, '/droplets/', {}) do |response|
         response['droplets'].each do |droplet|
            self << Droplet.new(@client, droplet)
         end
      end
    end

    def create(options={})

     [:name,:size_id, :image_id,:region_id].each do |key|
        raise "Required `#{key}` attribute" if not options.include?( key )
      end

      if not options[:ssh_keys].nil?
        options[:ssh_keys] = options[:ssh_keys].join(',')
      end

      @client.request(:get, '/droplets/new', options) do |response|
        puts response
      end

    end

  end
end
