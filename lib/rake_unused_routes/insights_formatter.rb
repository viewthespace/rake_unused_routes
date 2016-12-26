class RakeUnusedRoutes

  class InsightsFormatter

    class << self

      def convert_from_insights!
        actions = CSV.read(insights_csv_file_path).
          drop(1).map(&:first).reject{|r| r=~/Middleware/ }.
          map{ |r| r.sub('Controller/', '') }.
          map{|r| "#{r.split('/')[0..-2].
          map{|r| r.camelize}.join('::')}Controller##{r.split('/').last}" }.sort
          csv_file = CSV.generate do |csv|
            csv << [ 'Action' ]
            actions.each{ |action| csv << [ action ] }
          end
          FileUtils.mkdir_p './tmp'
          File.open('./tmp/controller_summary.csv', 'w+') do  |file|
            file.write csv_file
          end
      end

      private

      def insights_csv_file_path
        ENV.fetch('INSIGHTS_CONTROLLERS', './tmp/insights_controllers.csv')
      end

    end

  end

end
