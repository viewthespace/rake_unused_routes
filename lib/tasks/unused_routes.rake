namespace :unused_routes do

  desc 'Generates unused_routes from insights'
  task :from_insights do
    RakeUnusedRoutes::InsightsFormatter.convert_from_insights!
    Rake::Task['unused_routes'].invoke
  end

end

desc 'Prints out unused routes and unreachable action methods'
task :unused_routes => :environment do
  used_actions =
    RakeUnusedRoutes.actions_from_newrelic ENV.fetch('CONTROLLER_SUMMARY', './tmp/controller_summary.csv')
  puts RakeUnusedRoutes.new(Rails.application, used_actions: used_actions).formatted_unused_routes
end


