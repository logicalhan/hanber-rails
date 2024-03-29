require 'rails'
require 'hanber/rails/version'
require 'hanber/version'
require 'hanber/handlebars/version'
require 'hanber/rails/engine'

module Hanber
  module Rails
    class Railtie < ::Rails::Railtie
      config.ember = ActiveSupport::OrderedOptions.new

      generators do |app|
        app ||= ::Rails.application # Rails 3.0.x does not yield `app`

        app.config.generators.assets = false

        ::Rails::Generators.configure!(app.config.generators)
        ::Rails::Generators.hidden_namespaces.uniq!
        require "generators/hanber/resource_override"
      end

      initializer "ember_rails.setup_vendor", :after => "ember_rails.setup", :group => :all do |app|
        if variant = app.config.ember.variant
          # Add the gem's vendored ember to the end of the asset search path
          ember_path = File.expand_path("../../vendor/ember/#{variant}", __FILE__)
          app.config.assets.paths.push(ember_path.to_s)

          # Allow a local variant override
          ember_path = app.root.join("vendor/assets/ember/#{variant}")
          app.config.assets.paths.unshift(ember_path.to_s) if ember_path.exist?
        else
          warn "No ember.js variant was specified in your config environment."
          warn "You can set a specific variant in your application config in "
          warn "order for sprockets to locate ember's assets:"
          warn ""
          warn "    config.ember.variant = :development"
          warn ""
          warn "Valid values are :development and :production"
        end
      end

      initializer "ember_rails.find_ember", :after => "ember_rails.setup_vendor", :group => :all do |app|
        config.ember.ember_location ||= location_for(app, "ember.js")
        config.ember.handlebars_location ||= location_for(app, "handlebars.js")
      end

      initializer "ember_rails.es5_default", :group => :all do |app|
        if defined?(Closure::Compiler) && app.config.assets.js_compressor == :closure
          Closure::Compiler::DEFAULT_OPTIONS[:language_in] = 'ECMASCRIPT5'
        end
      end

      def location_for(app, file)
        path = app.config.assets.paths.find do |dir|
          Pathname.new(dir).join(file).exist?
        end

        File.join(path, file) if path
      end
    end
  end
end