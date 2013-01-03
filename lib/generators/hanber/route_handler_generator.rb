require 'hanber/version'

module Hanber
  module Generators
    class RouteHandlerGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new route handler"

      def create_view_files
        template 'route_handler.js', File.join('app/assets/javascripts/route_handlers', class_path, "#{file_name}_route.js")
      end
    end
  end
end
