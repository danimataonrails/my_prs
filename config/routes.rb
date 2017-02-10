Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users

  namespace :api do
    scope module: :v1 do
      resource :session, :only => [:create, :destroy, :show]
      resources :ex_types do
        resources :exercises
      end
      resources :marks
    end
  end
  
  #TODO: refactor DRY
  resources :users
  resources :ex_types do
    resources :exercises
  end
  resources :marks

end
