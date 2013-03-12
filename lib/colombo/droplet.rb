# encoding: utf-8

module Colombo
  class Droplet

    attr_accessor :id, :name, :image_id, :size_id, :region_id
    attr_accessor :backups_active, :ip_address, :status

    def initialize(client, droplet_hash = {})
      @client   = client
      if droplet_hash
        droplet_hash.each do |key, value|
          __send__("#{key}=", value) if self.respond_to?( key.to_sym )
        end
      end
    end

    def all
      droplets = []
      @client.request(:get, '/droplets/', {}) do |response|
         response['droplets'].each do |droplet|
            droplets << Droplet.new(@client, droplet)
         end
      end
      p droplets
      droplets
    end

    def find droplet_id
      @client.request(:get, "/droplets/#{droplet_id}") do |response|
        return Droplet.new(@client, response['droplet'])
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

    def reboot
      @client.request(:get, "/droplets/#{self.id}/reboot/") do |response|
        return response['event_id']
      end
    end

    def power_cycle
      @client.request(:get, "/droplets/#{self.id}/power_cycle/")
    end

    def shutdown
      @client.request(:get, "/droplets/#{self.id}/shutdown/")
    end

    def power_on
      @client.request(:get, "/droplets/#{self.id}/power_on/")
    end

    def password_reset
      @client.request(:get, "/droplets/#{self.id}/password_reset/")
    end

    def resize(size_id)
      @client.request(:get, "/droplets/#{self.id}/resize/", {
        :size_id => size_id
      })
    end

    def snapshot(name=nil)
      params = name.nil? ? {} : {:name => name}
      @client.request(:get, "/droplets/#{self.id}/snapshot/", params)
    end

    def restore(restore_image_id)
      @client.request(:get, "/droplets/#{self.id}/restore/", {
        :image_id => restore_id
      })
    end

    def rebuild(rebuild_image_id)
      @client.request(:get, "/droplets/#{self.id}/rebuild/", {:image_id => rebuild_image_id}) do |response|
        return response['event_id']
      end
    end

    def enable_backups
      @client.request(:get, "/droplets/#{self.id}/enable_backups/") do |response|
        return response['event_id']
      end
    end

    def disable_backups
      @client.request(:get, "/droplets/#{self.id}/disable_backups/") do |response|
        return response['event_id']
      end
    end

    def destroy(confirm=false)
      return false unless confirm
      @client.request(:get, "/droplets/#{self.id}/destroy/") do |response|
        return response['event_id']
      end
    end


  end
end
