module Hipbot
  module Helpers
    [:get, :post, :put, :delete].each do |http_verb|
      define_method http_verb do |url, query = {}, &block|
        query.merge!({ :head => {'accept-encoding' => 'gzip, compressed'} })
        conn = ::EM::HttpRequest.new(url, :connect_timeout => 5, :inactivity_timeout => 10)
        http = conn.send(http_verb, :query => query)
        http.callback{ block.call(HttpResponse.new(http)) } if block.present?
        http.errback{ Jabber::debuglog "REQUEST TIMEOUT (#{url})" }
      end

      module_function http_verb
    end

    class HttpResponse < Struct.new(:raw_response)
      def body
        raw_response.response
      end

      def code
        raw_response.response_header.status
      end

      def headers
        raw_response.response_header
      end

      def json
        @json ||= JSON.parse(body)
      end
    end
  end
end
