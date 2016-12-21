require "rake_unused_routes/version"

class RakeUnusedRoutes

  def initialize app, used_routes: []
    @app = app
    @unused_routes = unused_routes
  end

  def unused_routes
    Rails.application.routes.routes
  end

end
