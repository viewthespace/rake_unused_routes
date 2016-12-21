require "spec_helper"

describe RakeUnusedRoutes do

  subject{ RakeUnusedRoutes.new(Rails.application) }


  specify "all routes are unused" do
    expect(subject.unused_routes).to eq([])
  end

end
