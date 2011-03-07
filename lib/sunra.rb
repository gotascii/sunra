require "abstract_controller"
require "action_dispatch"
require "action_controller/metal"

module Sunra
  class Base < ActionController::Metal
    def self.inherited(klass)
      klass.class_eval do 
        @_routes = []
        @_app    = ActionDispatch::Routing::RouteSet.new
      end
    end
    
    class << self
      def get(uri, options = {}, &block)
        make_action(:get, uri, options, &block)
      end

      def make_action(http_method, uri, options, &block)
        action_name = "[#{http_method}] #{uri}"
        @_routes << {
          :method => http_method.to_s.upcase, 
          :uri => uri,
          :action => action_name,
          :options => options
        }
        define_method(action_name, &block)
      end

      def run_action(route)
        new.send(route[:action])
      end

      def to_app
        routes, app, controller = @_routes, @_app, self
        app.draw do
          routes.each do |route|
            match(route[:uri] => proc {|env| [200, {}, [controller.run_action(route)]] })
          end
        end
        app
      end
    end
  end
end