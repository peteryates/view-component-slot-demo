Rails.application.routes.draw do
  root "details#index"
  resources :details, only: :index
end
