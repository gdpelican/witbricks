Rails.application.routes.draw do
  root to: 'bricks#index'

  resources :bricks

  put '/bricks/promote/:id' => 'bricks#update', brick: { promote: true }, as: :promote_brick
end
