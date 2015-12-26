Rails.application.routes.draw do

  root "main#index"
  get "main/index"

  resources :budgies, except: [:new, :edit], :defaults => { :format => :json }
  resources :colors, except: [:new, :edit], :defaults => { :format => :json }

end
