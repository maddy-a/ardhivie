Ardhivie::Application.routes.draw do

  devise_for :users
  resources :ufiles, :except => :index
  resources :locations do
    resources :ufiles, :only => :index
  end
  namespace :api do
    root :to => "home#index"
    resources :ufiles, :except => :index
    resources :locations do
      collection do
        get :mine
      end
      resources :ufiles, :only => :index
    end
  end

  # You can have the root of your site routed with "root"
  # just remember todelete public/index.html.
  root :to => 'home#index'
  get "pages/home"
  get "pages/contact"
  get "pages/aboutus"
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
