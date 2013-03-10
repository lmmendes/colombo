# encoding: utf-8

module Colombo
  module Configuration

    VALID_CONNECTION_KEYS = [:endpoint, :user_agent].freeze

    VALID_OPTION_KEYS     = [:api_key, :client_id].freeze

    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTION_KEYS

    DEFAULT_END_POINT     = 'https://api.digitalocean.com'

    DEFAULT_USER_AGENT    = "Mozilla/5.0 (compatible; Colombo a Digital Ocean Ruby API Client/#{Colombo::VERSION}; +https://github/lmmendes/colombo)"

    DEFAULT_API_KEY       = nil

    DEFAULT_CLIENT_ID     = nil

    attr_accessor *VALID_CONFIG_KEYS

    def reset
      self.endpoint   = DEFAULT_END_POINT
      self.api_key    = DEFAULT_API_KEY
      self.client_id  = DEFAULT_CLIENT_ID
      self.user_agent = DEFAULT_USER_AGENT
    end

    def options
      Hash[ *VALID_CONFIG_KEYS.map{ |key| [key, send(key)] }.flatten ]
    end


    def configure
      yield self
    end

    def self.extended(base)
      base.reset
    end


  end
end
