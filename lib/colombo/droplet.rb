# encoding: utf-8

module Colombo
  class Droplet < Resource

    attr_accessor :id, :name, :image_id, :size_id, :region_id
    attr_accessor :backups_active, :ip_address, :status

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
