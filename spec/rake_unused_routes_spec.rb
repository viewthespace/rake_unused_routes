require "spec_helper"

describe RakeUnusedRoutes do


  before do

    DummyApp::Application.routes.draw do
      resources :users, :only => [:index, :show, :new, :create]

      namespace :admin do
        resources :shops, :only => :index
      end
    end

  end


  describe 'all routes not unused' do

    subject{ RakeUnusedRoutes.new(Rails.application) }

    it 'gives back all routes' do
      expect(subject.unused_routes.map{ |route| "#{route.requirements[:controller]}##{route.requirements[:action]}" }).to eq ["users#index", "users#create", "users#new", "users#show", "admin/shops#index"]
    end

  end

  describe 'all routes are used' do

    let(:used_routes){ %w{ UsersController#index UsersController#create UsersController#new UsersController#show Admin::ShopsController#index } }

    subject{ RakeUnusedRoutes.new(Rails.application, used_routes: used_routes) }

    it 'returns no routes' do
      expect(subject.unused_routes).to be_empty
    end

  end



end
