Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  namespace :admin do
  	devise_for :admin_users, controllers: { sessions: 'admin/internal_sessions' }
    resources :law_firms
  	resources :activity_logs
  	# devise_scope :admin_users do 
  	# 	resources :sessions
  	# end
	  root to: "internal_dashboard#index"
  end

  root to: "dashboard#index"
end
