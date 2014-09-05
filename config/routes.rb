Rails.application.routes.draw do
  root to: 'application#index'

  resources :bricks, defaults: { format: :json }
end
