# encoding: utf-8

require "colombo/region"

module Colombo
  class Event
    def self.find(client, event_id)
      client.request(:get, "/events/#{event_id}/", {}) do |response|
        return response
      end
    end
  end
end
