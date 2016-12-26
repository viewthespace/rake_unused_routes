class RakeUnusedRoutes

  class InsightsFormatter

    class << self

      def convert_from_insights!
        FileUtils.mkdir_p tmp_dir_path
        File.open("#{tmp_dir_path}/controller_summary.csv", 'w+') do |file|
          file.write csv_file
        end
      end

      private

      def csv_file
        CSV.generate do |csv|
          csv << [ 'Action' ]
          actions_from_insights.each{ |action| csv << [ action ] }
        end
      end

      def actions_from_insights
        CSV.read(insights_csv_file_path).
          drop(1).map(&:first).reject{|r| r=~/Middleware/ }.
          map{ |r| r.sub('Controller/', '') }.
          map{|r| "#{r.split('/')[0..-2].
          map{|r| r.camelize}.join('::')}Controller##{r.split('/').last}" }.sort
      end

      def tmp_dir_path
        './tmp'
      end

      def insights_csv_file_path
        ENV.fetch('INSIGHTS_CONTROLLERS', './tmp/insights_controllers.csv')
      end

    end

  end

end
