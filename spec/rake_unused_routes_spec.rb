require "spec_helper"

describe RakeUnusedRoutes do

  subject{ RakeUnusedRoutes.new(Rails.application) }

  before do

    DummyApp::Application.routes.draw do
      resources :users, :only => [:index, :show, :new, :create]

      namespace :admin do
        resources :shops, :only => :index
      end
    end

  end


  specify "all routes are unused" do
    expect(subject.unused_routes).to_not be_empty
  end

end
