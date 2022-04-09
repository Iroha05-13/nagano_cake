Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
