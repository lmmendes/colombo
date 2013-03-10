# encoding: utf-8

require "colombo/droplet"

module Colombo
  class Droplets < Array

    def initialize(client)
      @client = client
      @client.request(:get, '/droplets/', {}) do |response|
         response['droplets'].each do |droplet|
            self << Droplet.new(@client, self, droplet)
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

    def find(droplet_id)

      droplet = self.select{ |d| d.id == droplet_id }.first

      return droplet if not droplet.nil?

      response = @client.request(:get, "/droplets/#{droplet_id}") do |response|
        droplet = Droplet.new(@client, self, response['droplet'])
        self << droplet
      end

      return droplet
    end

  end
end
