# encoding: utf-8

module Colombo
  class Container < Array

    def method_missing(method, *args, &block)
      if method.to_s =~ /^find_by_(.*)/
        run_find_by_attr($1, *args)
      else
        super
      end
    end

    def run_find_by_attr(method, *args)
      self.select{ |item| item.send(method.to_sym) == args[0] }.first
    end

    def find(id)
      find_by_id(id)
    end

  end
end
