Rails.application.routes.draw do

  resources :budgies, except: [:new, :edit], :defaults => { :format => :json }
  resources :colors, except: [:new, :edit], :defaults => { :format => :json }

end
