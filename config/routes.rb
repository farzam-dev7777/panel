Rails.application.routes.draw do

  namespace :admin do
    devise_for :admin_users, controllers: { sessions: 'admin/internal_sessions' }
    resources :law_firms
    resources :activity_logs
    resources :forms
    resources :form_submissions
    # devise_scope :admin_users do 
    #   resources :sessions
    # end
    root to: "internal_dashboard#index"
  end

  devise_for :users, controllers: { sessions: 'users/sessions' }
  namespace :users do
  end
  root to: "dashboard#index"

end
