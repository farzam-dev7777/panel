Rails.application.routes.draw do

  namespace :admin do
    devise_for :admin_users, controllers: {
      sessions: 'admin/internal_sessions'
    }
    resources :law_firms do 
      member do
        get :begin_certification_process
        get :begin_recertification_process
      end
      collection do
        post :decertify
        post :add_internal_note
      end
    end

    resources :activity_logs do
      collection do
        get :mark_as_read
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

    resources :pdf do
      collection do
        get :activity_logs
      end
    end

    resources :severity_levels

    resources :security_alerts
    
    resources :follow_ups do
      collection do
        post :resolve
        post :review
      end
    end

    resources :notes
    resources :system_settings

    resources :security_threats do
      member do
        get :find_law_firms
        get :severity_negative_factors_for_triggers
      end
    end

    resources :form_submissions do
      member do
        get :policy_step
        get :process_step
        get :technology_step
        get :history_step
        patch :update_score
        post :save_and_follow_up
        post :approve
        post :decline
      end
      collection do
        post :mark_as_checked
        post :update_assessor_score
      end
    end
    get '/internal_dashboard/notifications', to: 'internal_dashboard#notifications'
    resources :internal_dashboard do
      collection do
        get :search_activity_logs
        get :seal_stats
        get :load_more_activities
      end
    end
    root to: "internal_dashboard#index"
  end
  
  resources :technologies do
    member do
      get :vendors
      get :platforms
      get :versions
      get :service_packs
    end
  end
  
  resources :technology_forms
  resources :history_forms
  resources :action_items do 
    collection do
      post :mark_as_complete
    end
  end

  resources :form_submissions do
    member do
      get :policy_step
      get :process_step
      get :technology_step
      get :history_step
      get :submit_forms
    end
  end

  resources :pdf do
    collection do
      get :activity_logs
    end
  end

  devise_for :users, controllers: { 
    sessions: 'users/sessions',
    passwords: 'users/passwords' 
  }
  resources :two_factor_authentication
  namespace :users do
  end
  root to: "dashboard#index"

end
