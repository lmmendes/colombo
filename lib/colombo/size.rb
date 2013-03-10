# encoding: utf-8
module Colombo
  class Size

    attr_accessor :id, :name

    def initialize(client, sizes, size_hash)
      @client = client
      @sizes  = sizes
      size_hash.each do |key, value|
        __send__("#{key}=", value) if self.respond_to?( key.to_sym )
      end
    end

  end
end
