Rails.application.routes.draw do
  get 'inquiry/new', to: 'inquiry#new'
  post 'inquiry/confirm', to: 'inquiry#confirm'
  post 'inquiry/create', to: 'inquiry#create'
end
