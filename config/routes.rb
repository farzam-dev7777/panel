Rails.application.routes.draw do

  get '/auth/docusign/callback', to: 'dashboard#docusign_callback'
  
  namespace :admin do
    devise_for :admin_users, controllers: {
      sessions: 'admin/internal_sessions'
    }
    resources :users do
      collection do
        get :edit_profile 
        get 'send_user_info/:id' => 'users#send_user_info', :as => "send_user_info"
        get 'send_user_info_with_certification/:id' => 'users#send_user_info_with_certification', :as => "send_user_info_with_certification"
        get 'edit_profile/:id' => 'users#edit_profile', :as => "users_edit_profile"
        post 'update_profile/:id' => 'users#update_profile', :as => "users_update_profile"
      end
    end
    
    resources :file_attachments do
      member do
        get :decrypt
      end
    end
    resources :law_firms do 
      member do
        
        get :begin_certification_process
        get :begin_recertification_process
      
      end
      collection do
        get :panel_law_firms
        get :panel_non_law_firms
        post :get_sub_matter_types 
        post :get_state
        post :get_law_firm_list
        post :decertify
        post :add_internal_note
        post :remove_internal_note
        post :get_detail
        get :add_by_submission
        
      end
    end

    resources :matter_intakes do 
      member do 
        get :review
        get :lxp_review
      end
      collection do 
        post :lxp_rejects
        get ':matter_intake_id/information_security_classification' => 'matter_intakes#information_security_classification', :as => "matter_intakes_information_security_classification"
        post ':matter_intake_id/information_security_classification' => 'matter_intakes#update_information_security_classification', :as => "matter_intakes_update_information_security_classification"
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

    resources :frequently_asked_questions
    resources :faq_categories
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
        get :pricing_step
        get :relationship_step
        get :diversity_step
        get :innovation_step
        get :resourcing_step
        get :lawfirm_step
        get :process_step
        get :technology_step
        get :history_step
        patch :update_score
        post :save_and_follow_up
        post :approve
        post :decline
        post :law_firm_update
        get  :download_submission_pdf
      end
      collection do
        post :mark_as_checked
        post :update_assessor_score
        post :set_expiry_date
      end
    end
    resources :exception_requests do
      get :download_pdf 
      collection do
        post :send_retainer_aggreement
        get :engage_non_panel_firm 
        post :get_sub_matter_types 
        post :get_state
        post :get_law_firm_list
        get :select_law_firm 
        get 'select_law_firm/:id' => 'exception_requests#select_law_firm'
        get ':law_firm_id/new' => 'exception_requests#new', :as => "exception_request_new"
        get ':exception_request_id/new_engage_non_panel_firm' => 'exception_requests#new_engage_non_panel_firm', :as => "exception_request_new_engage"
        get ':exception_request_id/update_engage_non_panel_firm' => 'exception_requests#update_engage_non_panel_firm', :as => "exception_request_update_engage"
        get ':law_firm_new/create' => 'exception_requests#law_firm_new', :as => "law_firm_new_create"
        post :law_firm_create
      end
    end
    resources :panel_requests do
      get   :download_pdf
      collection do
        post  :send_wnn_documents
      end
    end
    resources :conflict_waivers
    resources :reviews
    resources :comments
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

  namespace :lob do
    resources :users do
      collection do
        get :edit_profile 
        get 'edit_profile/:id' => 'users#edit_profile', :as => "users_edit_profile"
        post 'update_profile/:id' => 'users#update_profile', :as => "users_update_profile"
      end
    end
    resources :law_firms do 
      member do
        get :begin_certification_process
        get :begin_recertification_process
      
      end
      collection do
        post :decertify
        post :add_internal_note
        post :remove_internal_note
        post :get_detail
        get :add_by_submission
      end
    end

    resources :matter_intakes do
      collection do
        get ':matter_intake_id/information_security_classification' => 'matter_intakes#information_security_classification', :as => "matter_intakes_information_security_classification"
      end
    end

    resources :activity_logs do
      collection do
        get :mark_as_read
      end
    end
    resources :panel_requests do
      get :download_pdf 
    end
    resources :comments
    resources :exception_requests do
      collection do
        get :engage_non_panel_firm 
        post :get_sub_matter_types 
        post :get_state
        post :get_law_firm_list
        get :select_law_firm 
        get 'select_law_firm/:id' => 'exception_requests#select_law_firm'
        get ':law_firm_id/new' => 'exception_requests#new', :as => "exception_request_new"
        get ':exception_request_id/new_engage_non_panel_firm' => 'exception_requests#new_engage_non_panel_firm', :as => "exception_request_new_engage"
        get ':exception_request_id/update_engage_non_panel_firm' => 'exception_requests#update_engage_non_panel_firm', :as => "exception_request_update_engage"
        get ':law_firm_new/create' => 'exception_requests#law_firm_new', :as => "law_firm_new_create"
        post :law_firm_create
      end
    end

    
    root to: "internal_dashboard#index"
  end
  
  # resources :law_firms
  resources :security_alerts
  resources :technologies do
    member do
      get :vendors
      get :platforms
      get :versions
      get :service_packs
    end
  end
  resources :follow_ups do
    collection do
      post :review
    end
  end
  resources :technology_forms
  resources :history_forms
  resources :action_items do 
    collection do
      post :mark_as_complete
    end
  end

  patch "file_attachments/:id/:type" => "file_attachments#create", :as => "file_attachments_uploader"
  patch "file_attachments/" => "file_attachments#create", :as => "file_attachments_without_object"
  patch "form_submissions/:id/technology_step_bulk_upload" => "form_submissions#technology_step_bulk_upload", :as => "technology_step_bulk_upload"
  resources :file_attachments
  resources :form_submissions do
    member do
      get :pricing_step
      get :relationship_step
      get :diversity_step
      get :innovation_step
      get :resourcing_step
      get :lawfirm_step
      get :process_step
      get :technology_step
      get :history_step
      get :submit_forms
      get :technology_profile
      post :law_firm_update
      get :history_profile
    end
  end

  resources :law_firms, except: [:index, :create, :new, :show] do
    collection do
      get :add_users
      post :invite_users
    end
  end

  resources :conflict_waivers do 
    collection do 
      get ':conflict_waiver_id/client_info' => 'conflict_waivers#client_info', :as => "conflict_waivers_client_info"
      post :client_info_update
    end
  end

  resources :technology_values do
    collection do
      post :import
    end
  end

  resources :pdf do
    collection do
      get :activity_logs
    end
  end

  get 'set_new_password' => 'law_firms#set_new_password'
  get 'pull_qr_code' => 'two_factor_authentication#pull'
  post 'delete_user' => 'law_firms#delete_user'
  post 'update_new_password' => 'law_firms#update_new_password'

  resources 'frequently_asked_questions', only: [:index]

  devise_for :users, skip: [:registrations], controllers: { 
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  as :user do 
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
    patch 'users/update' => 'users/registrations#update', :as => 'user_registration'
  end
  resources :two_factor_authentication do
    collection do
      get :send_two_factor_auth_again
    end
  end
  namespace :users do
  end



  root to: "dashboard#index"

end
