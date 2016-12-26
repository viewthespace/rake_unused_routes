require "rake_unused_routes/version"
require "rake_unused_routes/insights_formatter"
require 'csv'

class RakeUnusedRoutes

  class Railtie < ::Rails::Railtie
    rake_tasks do
      load File.join(File.dirname(__FILE__), 'tasks/unused_routes.rake')
    end
  end

  def initialize app, used_actions: []
    @app = app
    @used_actions = used_actions
  end

  def unused_routes
    routes.reject do |route|
      @used_actions.include?( newrelic_formatting(route) )
    end
  end

  def formatted_unused_routes
    inspector = ActionDispatch::Routing::RoutesInspector.new(unused_routes)
    inspector.format(ActionDispatch::Routing::ConsoleFormatter.new, ENV['CONTROLLER'])
  end

  def self.actions_from_newrelic(file)
    new_relic_controller_actions = []
    CSV.foreach(file, :col_sep => ",") do |row|
      if row.first && !['HttpDispatcher','Action'].include?(row.first.chomp) && !row.first.chomp.include?('#(template only)')
        new_relic_controller_actions << row.first.chomp
      end
    end
    new_relic_controller_actions.uniq
  end

  private

  def newrelic_formatting route
    requirements = route.requirements
    "#{requirements[:controller].camelize}Controller##{requirements[:action]}"
  end

  def routes
    @app.routes.routes.select{ |route| route.requirements[:controller] }.
        reject {|r| r.requirements[:controller].starts_with? 'rails/' }
  end

end
