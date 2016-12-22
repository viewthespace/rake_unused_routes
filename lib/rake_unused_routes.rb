require "rake_unused_routes/version"

class RakeUnusedRoutes

  def initialize app, used_routes: []
    @app = app
    @used_routes = used_routes
  end

  def unused_routes
    routes.reject do |route|
      @used_routes.include?( newrelic_formatting(route) )
    end
  end

  def formatted_unused_routes
    inspector = ActionDispatch::Routing::RoutesInspector.new(unused_routes)
    inspector.format(ActionDispatch::Routing::ConsoleFormatter.new, ENV['CONTROLLER'])
  end

  private

  def newrelic_formatting route
    requirements = route.requirements
    "#{requirements[:controller].camelize}Controller##{requirements[:action]}"
  end

  def routes
    Rails.application.routes.routes.select{ |route| route.requirements[:controller] }.
        reject {|r| r.requirements[:controller].starts_with? 'rails/' }
  end

end
