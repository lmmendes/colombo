# encoding: utf-8

module Colombo
  class Client

    include Request

    attr_accessor *Configuration::VALID_CONFIG_KEYS

    def initialize(options={})

      merge_options = Colombo.options.merge(options)
      Configuration::VALID_CONFIG_KEYS.each do |key|
        self.send("#{key}=", merge_options[key])
      end

    end

    def droplets
      Droplets.new(self)
    end

    def regions
      Regions.new(self)
    end

    def images(options={})
      Images.new(self, options)
    end

    def sizes
      Sizes.new(self)
    end

    def ssh_keys
      SshKeys.new(self)
    end

  end
end
