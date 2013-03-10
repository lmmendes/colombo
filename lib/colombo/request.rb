# encoding: utf-8

module Colombo
  module Request

    def request(method=:get, uri='/', params={}, &block)

      params[:client_id] = self.client_id
      params[:api_key]   = self.api_key

      url = self.endpoint + uri

      if method.to_sym == :get
        params = { :params => params }
        params[:client_id] = self.client_id
        params[:api_key]   = self.api_key
      else
        url += "?client_id=#{self.client_id}&api_key=#{self.api_key}"
      end

      # puts "url: #{url}"

      response = nil
      begin
        response = RestClient.send(method, url, params)
      rescue => e
        $stderr.puts e.inspect
        raise
      end

      # puts response.inspect

      response = JSON.parse(response)
      if response['status'].to_s.downcase == 'ok'
        if block_given?
          block.call(response)
          return
        else
          return response
        end
      end

      raise response['error_message']

    end

  end
end
