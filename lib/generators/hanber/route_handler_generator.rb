require 'ember/version'

module Ember
  module Generators
    class RouteHandlerGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new route handler"
      class_option :array, :type => :boolean, :default => false, :desc => "Create an Ember.ArrayController to represent multiple objects"
      class_option :object, :type => :boolean, :default => false, :desc => "Create an Ember.ObjectController to represent a single object"

      def create_view_files
        template 'route_handler.js', File.join('app/assets/javascripts/route_handlers', class_path, "#{file_name}_route.js")
      end
    end
  end
end
