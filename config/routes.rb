Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'

  resources :home do
    collection do
      get :user_chat
    end
  end

  resources :parse

end
