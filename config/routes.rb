# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :shops, only: %i(index create)
      resources :shops, except: %i(index create), param: :domain
      resources :sellers, only: %i(create show), param: :customer_id
    end
  end
end
