Rails.application.routes.draw do

  namespace :admin do
    devise_for :admin_users, controllers: { sessions: 'admin/internal_sessions' }
    resources :law_firms
    resources :activity_logs
    resources :form_submissions do
      member do
        get :policy_step
        get :process_step
        get :technology_step
        get :history_step
      end
    end
    resources :forms do
      collection do
        get :group_form_fields
      end
      member do
        post :duplicate
      end
    end
    resources :messages
    get '/internal_dashboard/notifications', to: 'internal_dashboard#show'
	  root to: "internal_dashboard#index"
  end

  devise_for :users, controllers: { sessions: 'users/sessions' }
  namespace :users do
  end
  root to: "dashboard#index"

end
