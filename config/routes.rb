Rails.application.routes.draw do

  namespace :admin do
    devise_for :admin_users, controllers: { sessions: 'admin/internal_sessions' }
    resources :law_firms
    resources :activity_logs
    resources :forms
    resources :form_submissions
    resources :form_fields, :only => [:index] do
      member do
        post :move
      end
    end
    # devise_scope :admin_users do 
    #   resources :sessions
    # end
    get '/internal_dashboard/notifications', to: 'internal_dashboard#show'
	  root to: "internal_dashboard#index"
  end

  devise_for :users, controllers: { sessions: 'users/sessions' }
  namespace :users do
  end
  root to: "dashboard#index"

end
