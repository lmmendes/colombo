# encoding: utf-8

$:.unshift File.expand_path(File.dirname(__FILE__))

require 'json'
require 'rest-client'

require "colombo/version"
require "colombo/configuration"
require "colombo/request"
require "colombo/droplet"
require "colombo/droplets"
require "colombo/region"
require "colombo/regions"
require "colombo/image"
require "colombo/images"
require "colombo/ssh_keys"
require "colombo/client"
require "colombo/sizes"


module Colombo
  extend Configuration


  def self.new(options={})
    Client.new(options)
  end


end
