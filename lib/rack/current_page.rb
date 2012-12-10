require 'rack_replace'

module Rack
  class CurrentPage < Rack::Replace

    def initialize app, klass = 'current'
      super app, /\<a[^\>]*>/ do |env, link|
        request = Rack::Request.new env

        link = Link.new link
        path = request.path
        path += '?' + request.query_string unless request.query_string.empty?
        link.append_class! klass if link.points_to? path
        link.to_s
      end
    end

  end
end

require 'rack/current_page/link'
