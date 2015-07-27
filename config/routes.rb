Rails.application.routes.draw do
  resources :day_hours do
    delete 'destroy_all', on: :collection
  end

  root 'application#index'
end
