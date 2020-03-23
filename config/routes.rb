Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  defaults format: :json do
    root 'feed#index'
  end
end
