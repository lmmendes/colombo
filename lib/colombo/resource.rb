# encoding: utf-8

module Colombo
  class Resource

    def initialize(client, attr_hash)
      @client   = client
      if attr_hash
        attr_hash.each do |key, value|
          __send__("#{key}=", value) if self.respond_to?( key.to_sym )
        end
      end
    end
  end
end
