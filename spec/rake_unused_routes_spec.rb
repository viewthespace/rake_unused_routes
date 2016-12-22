require "spec_helper"

describe RakeUnusedRoutes do

  def format_route(route)
    "#{route.requirements[:controller]}##{route.requirements[:action]}"
  end

  def format_routes routes
    routes.map{ |route| format_route(route) }
  end

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
      expect(format_routes(subject.unused_routes)).to eq ["users#index", "users#create", "users#new", "users#show", "admin/shops#index"]
    end

  end

  describe 'all routes are used' do

    let(:used_routes){ %w{ UsersController#index UsersController#create UsersController#new UsersController#show Admin::ShopsController#index } }

    subject{ RakeUnusedRoutes.new(Rails.application, used_routes: used_routes) }

    it 'returns no routes' do
      expect(subject.unused_routes).to be_empty
    end

  end

  describe 'all but one route is used' do

    let(:used_routes){ %w{ UsersController#create UsersController#new UsersController#show Admin::ShopsController#index } }

    subject{ RakeUnusedRoutes.new(Rails.application, used_routes: used_routes) }

    let(:formatted_unused_routes) do
      "Prefix Verb URI Pattern      Controller#Action\n users GET  /users(.:format) users#index"
    end

    it 'returns one route' do
      expect(format_routes(subject.unused_routes)).to eq ["users#index"]
    end

    it 'returns one formatted route' do
      expect(subject.formatted_unused_routes).to eq formatted_unused_routes
    end

  end

end
