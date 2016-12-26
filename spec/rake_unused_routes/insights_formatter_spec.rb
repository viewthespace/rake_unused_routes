require 'spec_helper'

class RakeUnusedRoutes

  describe InsightsFormatter do

    let(:output_file){ './tmp/controller_summary.csv' }


    before do
      File.delete(output_file) if File.exists?(output_file)
      ENV['INSIGHTS_CONTROLLERS'] = "#{File.dirname(__FILE__)}/insights_controllers.csv"
    end

    let(:expected_results) do
      "Action\nAdmin::ShopsController#show\nUsersController#create\nUsersController#show\n"
    end

    specify do
      InsightsFormatter.convert_from_insights!
      expect(File.read(output_file)).to eq expected_results
    end

  end

end
