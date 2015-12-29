Rails.application.routes.draw do

  root  "main#index"
  get   "main/index"

  resources :budgies, except: [:new, :edit], :defaults => { :format => :json } do
    member do
      get "descendents"
      get "ancestors"
    end
  end

  resources :colors, except: [:new, :edit], :defaults => { :format => :json }

end
