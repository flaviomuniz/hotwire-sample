Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :employees, only: %i[index show] do
    get 'edit', on: :member
    patch 'edit', on: :member, to: 'employees#update'
  end

  root to: redirect('/employees')
end
