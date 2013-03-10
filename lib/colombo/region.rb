# encoding: utf-8
module Colombo
  class Region

    attr_accessor :id, :name

    def initialize(client, regions, region_hash)
      @client   = client
      @regions  = regions
      region_hash.each do |key, value|
        __send__("#{key}=", value) if self.respond_to?( key.to_sym )
      end
    end

  end
end
