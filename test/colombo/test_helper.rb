# encoding: utf-8

require 'rubygems'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = File.join( File.dirname(__FILE__),  'fixtures/vcr_cassettes')
  c.hook_into :webmock
end

COLOMBO_DROPLET_NAME = 'colombo'
COLOMBO_REGION_ID    = 1      # NY
COLOMBO_IMAGE_ID     = 42735  # Ubuntu
COLOMBO_SIZE_ID      = 63     # 1GB
COLOMBO_SSH_KEY_NAME = 'colombo gem'
COLOMBO_SSH_KEY      = 'ssh-dss AAAAB3NzaC1kc3MAAACBAK5uLwicCrFEpaVKBzkWxC7RQn+smg5ZQb5keh9RQKo8AszFTol5npgUAr0JWmqKIHv7nof0HndO86x9iIqNjq3vrz9CIVcFfZM7poKBJZ27Hv3v0fmSKfAc6eGdx8eM9UkZe1gzcLXK8UP2HaeY1Y4LlaHXS5tPi/dXooFVgiA7AAAAFQCQl6LZo/VYB9VgPEZzOmsmQevnswBBBIBCNKGsVP5eZ+IJklXheUyzxuL75i04OOtEGW6MO5TymKMwTZlU9r4ukuwxty+T9Ot2LqlNRnLSPQAjb0vplasZ8Ix45JOpRbuSvPovryn7rvS7//klu9hIkFAAQ/AZfGTw+696EjFBg4F5tN6MGMA6KrTQVLXeuYcZeRXwE5t5lwAAAIEAl2xYh098bozJUANQ82DiZznjHc5FW76Xm1apEqsZtVRFuh3V9nc7QNcBekhmHp5Z0sHthXCm1XqnFbkRCdFlX02NpgtNs7OcKpaJP47N8C+C/Yrf8qK/Wt3fExrL2ZLX5XD2tiotugSkwZJMW5Bv0mtjrNt0Q7P45rZjNNTag2c= user@host'


require File.expand_path('../../../lib/colombo.rb', __FILE__)
