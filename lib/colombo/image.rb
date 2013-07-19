# encoding: utf-8
module Colombo
  class Image < Resource

    attr_accessor :id, :name, :distribution

    def destroy(confirm=false)
      raise 'must pass true for confirm' unless confirm
      @client.request(:get, "/images/#{self.id}/destroy/") do |response|
        return response['event_id']
      end
    end

  end
end
