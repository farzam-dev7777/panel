# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_07_11_144212) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "action_items", id: :serial, force: :cascade do |t|
    t.integer "security_threat_id"
    t.integer "law_firm_id"
    t.string "status"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_id", null: false
    t.string "resource_type", null: false
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "activities", id: :serial, force: :cascade do |t|
    t.string "trackable_type"
    t.integer "trackable_id"
    t.string "owner_type"
    t.integer "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.integer "recipient_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "activity_logs", id: :serial, force: :cascade do |t|
    t.integer "law_firm_id"
    t.string "event_type"
    t.string "custom_message"
    t.string "loggable_type"
    t.integer "loggable_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "read"
    t.boolean "notify"
    t.string "email"
    t.string "source"
    t.string "status"
    t.index ["loggable_type", "loggable_id"], name: "index_activity_logs_on_loggable_type_and_loggable_id"
  end

  create_table "activity_time_logs", id: :serial, force: :cascade do |t|
    t.date "network_discovery"
    t.date "penetration_testing"
    t.date "vulnerability_assessment"
    t.date "hardware_refresh"
    t.date "hardware_inventory"
    t.date "software_inventory"
    t.integer "form_value_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "network_discovery_never", default: false
    t.boolean "penetration_testing_never", default: false
    t.boolean "vulnerability_assessment_never", default: false
    t.boolean "hardware_refresh_never", default: false
    t.boolean "hardware_inventory_never", default: false
    t.boolean "software_inventory_never", default: false
  end

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "role"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "proposal_id"
    t.integer "question_id"
    t.integer "rfp_id"
    t.text "response"
    t.datetime "date"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cloud_providers", id: :serial, force: :cascade do |t|
    t.integer "form_value_id"
    t.string "name"
    t.string "service"
    t.string "data_store_location_ca"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "cloud_type"
    t.string "data"
    t.string "encrypted_in_flight"
    t.string "encrypted_at_rest"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "commentable_id"
    t.string "commentable_type"
    t.string "title"
    t.text "body"
    t.string "subject"
    t.integer "user_id", null: false
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "assigned_to_id"
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "conflict_waivers", id: :serial, force: :cascade do |t|
    t.string "name_of_law_firm"
    t.string "contact_details"
    t.string "bmo_business_contact"
    t.text "reason"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "confirm_waiver"
    t.string "lxp_status"
    t.string "internal_lawyers_status"
    t.integer "law_firm_id"
    t.integer "assigned_to_id"
    t.text "retainer_language"
    t.text "retainer_cover"
    t.string "repesenting"
    t.text "name_of_other_client"
    t.text "description_of_transaction"
    t.text "nature_of_mandate"
    t.text "office_locattion"
    t.text "names_of_primary"
    t.text "types_of_matters"
  end

  create_table "countries", id: :serial, force: :cascade do |t|
    t.integer "country_id"
    t.string "name"
    t.string "iso"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "position"
  end

  create_table "cyber_security_insurances", id: :serial, force: :cascade do |t|
    t.string "company"
    t.string "coverage"
    t.string "coverage_amount"
    t.string "policy"
    t.string "form_value_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.date "date_of_expiry"
    t.string "standing"
  end

  create_table "cyber_security_standards", id: :serial, force: :cascade do |t|
    t.string "rank"
    t.string "standard"
    t.date "date_of_certification"
    t.date "renewal"
    t.integer "form_value_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "status"
  end

  create_table "dropdown_options", id: :serial, force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.integer "form_field_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.float "score", default: 0.0
  end

  create_table "exception_requests", id: :serial, force: :cascade do |t|
    t.string "requested_by"
    t.integer "user_id"
    t.string "submitted_by_email"
    t.string "line_of_business"
    t.string "lob_contact_name"
    t.integer "law_firm_id"
    t.string "request_type"
    t.string "law_firm_category"
    t.string "minority_owned"
    t.text "minority_owned_details"
    t.string "women_owned"
    t.text "women_owned_details"
    t.string "matter_name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "matter_types"
    t.string "law_firm_name"
    t.string "business_manager_name"
    t.string "business_manager_phone"
    t.string "business_manager_email"
    t.string "lxp_status"
    t.integer "lxp_id"
    t.string "internal_lawyers_status"
    t.integer "internal_lawyers_id"
    t.string "docusign_envelope_id"
    t.string "pay_type"
    t.text "notes"
    t.string "is_work"
    t.text "reason"
    t.string "payer"
    t.text "matter_types_search"
    t.text "sub_matter_types_search"
    t.text "jurisdiction_types_search"
    t.text "countries_search"
    t.text "states_search"
    t.boolean "niche_preferred_external_counsel_panel_law_firms", default: false
    t.text "niche_expertise"
    t.boolean "required_unique_geography", default: false
    t.text "geographic_location"
    t.string "involved_engagement"
    t.text "reson_other"
    t.string "mode_of_payment"
    t.string "matter_description"
    t.string "matter_involve_following"
    t.string "jurisdiction"
    t.text "reason_details"
    t.string "receive_personal_information"
    t.string "receive_general_business_data"
    t.string "applicable_technical_specialty_data"
    t.text "receive_personal_information_data_type"
    t.text "receive_general_business_data_type"
    t.text "applicable_technical_specialty_data_type"
    t.string "law_firm_email"
    t.string "law_firm_phone"
    t.string "firm_use_on_regular_basis"
  end

  create_table "external_lawyer_matter_intakes", id: :serial, force: :cascade do |t|
    t.integer "external_lawyer_id"
    t.integer "matter_intake_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "external_lawyers", id: :serial, force: :cascade do |t|
    t.integer "law_firm_id"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "faq_categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "feedbacks", id: :serial, force: :cascade do |t|
    t.integer "law_firm_id"
    t.integer "feedbacks_id"
    t.string "feedback"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "file_attachments", id: :serial, force: :cascade do |t|
    t.string "file"
    t.integer "form_value_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "iv"
    t.text "key"
    t.string "attachable_type"
    t.integer "attachable_id"
  end

  create_table "follow_ups", id: :serial, force: :cascade do |t|
    t.integer "form_submission_id"
    t.string "loggable_type"
    t.integer "loggable_id"
    t.string "status"
    t.integer "note_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "form_fields", id: :serial, force: :cascade do |t|
    t.string "min"
    t.string "max"
    t.boolean "required"
    t.string "label"
    t.string "type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "form_id"
    t.integer "formable_id"
    t.string "formable_type"
    t.integer "parent_id"
    t.integer "position"
    t.integer "group_form_id"
    t.boolean "repeater"
    t.boolean "custom_logic"
    t.integer "show_when_form_field_id"
    t.string "show_when_form_field_value"
    t.boolean "scored"
    t.float "score"
    t.text "help_description"
    t.index ["position"], name: "index_form_fields_on_position"
  end

  create_table "form_submissions", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "form_id"
    t.integer "form_process_id"
    t.boolean "submitted", default: false
    t.datetime "submitted_on", precision: nil
    t.integer "law_firm_id"
    t.float "total_score"
    t.string "status"
    t.string "reason"
    t.float "assessor_score"
    t.float "system_score"
    t.date "expiry_date"
    t.integer "locked_by_id"
    t.datetime "locked_at", precision: nil
    t.integer "last_submitted_by_id"
    t.datetime "approved_at", precision: nil
    t.string "evidence_status"
    t.integer "form_relationship_id"
    t.integer "form_diversity_id"
    t.integer "form_innovation_id"
    t.integer "form_resourcing_id"
    t.integer "form_conflicts_id"
  end

  create_table "form_values", id: :serial, force: :cascade do |t|
    t.integer "form_field_id"
    t.integer "submittable_id"
    t.string "value"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "submittable_type"
    t.string "form_field_label"
    t.string "file_value"
    t.boolean "checked", default: false
    t.string "form_value_iv"
    t.string "form_value_key"
    t.text "multi_select_value"
    t.float "score", default: 0.0
  end

  create_table "forms", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "group_form"
    t.string "step"
  end

  create_table "frequently_asked_questions", id: :serial, force: :cascade do |t|
    t.string "question"
    t.text "answer"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "faq_category_id"
  end

  create_table "history_submissions", id: :serial, force: :cascade do |t|
    t.string "incident_type"
    t.string "impact"
    t.string "discovery_time"
    t.string "source"
    t.string "data_loss"
    t.text "incident_details"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "form_submission_id"
    t.boolean "checked", default: false
  end

  create_table "information_security_policies", id: :serial, force: :cascade do |t|
    t.string "policy"
    t.date "last_reviewed"
    t.date "last_updated"
    t.string "freq_of_review"
    t.integer "form_value_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "upload_policy"
    t.string "independent_review"
    t.string "communication_status"
  end

  create_table "internal_notes", id: :serial, force: :cascade do |t|
    t.text "message"
    t.integer "sender_id"
    t.integer "law_firm_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "invoice_attachments", id: :serial, force: :cascade do |t|
    t.integer "invoice_id"
    t.string "file"
    t.text "iv"
    t.text "key"
    t.string "file_content_type"
    t.string "file_size"
    t.string "human_file_size"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.jsonb "veryfi_response"
  end

  create_table "invoices", id: :serial, force: :cascade do |t|
    t.integer "matter_intake_id"
    t.string "lawyer_name"
    t.float "rate", default: 0.0
    t.string "rate_type"
    t.string "description"
    t.float "hours"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "CAD", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "status"
    t.date "date"
    t.integer "taxes"
  end

  create_table "issues", id: :serial, force: :cascade do |t|
    t.integer "law_firm_id"
    t.integer "issues_id"
    t.string "issue"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "jurisdiction_types", id: :serial, force: :cascade do |t|
    t.string "jurisdiction_type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "jurisdictions", id: :serial, force: :cascade do |t|
    t.string "country"
    t.string "city"
    t.integer "law_firm_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "law_firm_attachments", id: :serial, force: :cascade do |t|
    t.integer "law_firm_id"
    t.integer "tenant_id"
    t.string "file"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "law_firms", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.string "relationship_manager_email"
    t.string "law_firm_type"
    t.text "parent_company"
    t.string "practice_area"
    t.text "sister_firm"
    t.string "principle_name"
    t.string "principle_title"
    t.text "principle_contact_info"
    t.boolean "profile_completed", default: false
    t.integer "max_users"
    t.string "public_uid"
    t.boolean "updated_by_lawfirm", default: false
    t.datetime "initial_date_of_engagement_with_the_bank", precision: nil
    t.text "type_of_services_your_law_firm_provides_generally"
    t.text "confidentiality_level_of_matters_that_are_handled"
    t.string "number_of_lawyers"
    t.string "relationship_manager_name"
    t.string "relationship_manager_phone"
    t.string "law_firm_category"
    t.string "firm_use_on_regular_basis"
    t.string "status"
    t.string "secondary_rm_contact"
    t.string "secondary_rm_contact_email"
    t.string "billing_contact_name"
    t.string "billing_contact_email"
    t.string "information_security_contact"
    t.string "information_security_contact_email"
    t.string "diverse"
    t.text "value_add_activities"
    t.text "feedback"
    t.text "issues"
    t.string "merger_combination"
    t.string "engagement_number"
    t.string "relationship_number"
    t.string "information_security_class"
    t.string "information_security_assessment_outcome"
    t.string "action_plan_findings"
    t.string "action_plan_status"
    t.string "contact_name"
    t.string "bmo_relationship_partner_name"
    t.string "bmo_relationship_partner_email"
    t.string "bmo_relationship_partner_phone_number"
    t.string "panel_status"
    t.datetime "deleted_at"
  end

  create_table "law_firms_countries", id: :serial, force: :cascade do |t|
    t.integer "law_firm_id"
    t.integer "country_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "law_firms_jurisdiction_types", id: :serial, force: :cascade do |t|
    t.integer "law_firm_id"
    t.integer "jurisdiction_type_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "law_firms_matter_types", id: :serial, force: :cascade do |t|
    t.integer "law_firm_id"
    t.integer "matter_type_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "law_firms_states", id: :serial, force: :cascade do |t|
    t.integer "law_firm_id"
    t.integer "state_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "law_firms_sub_matter_types", id: :serial, force: :cascade do |t|
    t.integer "law_firm_id"
    t.integer "sub_matter_type_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "law_firms_tenants", id: :serial, force: :cascade do |t|
    t.integer "law_firm_id"
    t.integer "tenant_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "initial_date_of_engagement_with_the_bank", precision: nil
    t.string "bmo_relationship_partner_name"
    t.string "bmo_relationship_partner_email"
    t.string "bmo_relationship_partner_phone_number"
    t.string "secondary_rm_contact"
    t.string "secondary_rm_contact_email"
    t.string "billing_contact_name"
    t.string "billing_contact_email"
    t.string "engagement_number"
    t.string "relationship_number"
    t.string "information_security_class"
    t.string "information_security_assessment_outcome"
    t.string "action_plan_findings"
    t.string "action_plan_status"
    t.string "information_security_contact"
    t.string "information_security_contact_email"
    t.boolean "allow_to_create_matters"
    t.string "document"
    t.string "status"
    t.text "type_of_matters_your_law_firm_handles_for_us"
  end

  create_table "lawyer_matter_intakes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "matter_intake_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_of_business_users", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "line_of_business_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "line_of_businesses", id: :serial, force: :cascade do |t|
    t.string "sso_group"
    t.string "name"
    t.integer "tenant_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "email"
  end

  create_table "lob_ssos", id: :serial, force: :cascade do |t|
    t.string "id_on_sso_provider"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "locations", id: :serial, force: :cascade do |t|
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "province"
    t.string "country"
    t.string "postal_code"
    t.integer "law_firm_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "logics", id: :serial, force: :cascade do |t|
    t.integer "listen_field_id"
    t.integer "change_field_id"
    t.integer "form_id"
    t.string "logic_to_be_applied"
    t.string "values"
    t.string "perform_action"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "mailboxer_conversation_opt_outs", id: :serial, force: :cascade do |t|
    t.string "unsubscriber_type"
    t.integer "unsubscriber_id"
    t.integer "conversation_id"
    t.index ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id"
    t.index ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type"
  end

  create_table "mailboxer_conversations", id: :serial, force: :cascade do |t|
    t.string "subject", default: ""
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "mailboxer_notifications", id: :serial, force: :cascade do |t|
    t.string "type"
    t.text "body"
    t.string "subject", default: ""
    t.string "sender_type"
    t.integer "sender_id"
    t.integer "conversation_id"
    t.boolean "draft", default: false
    t.string "notification_code"
    t.string "notified_object_type"
    t.integer "notified_object_id"
    t.string "attachment"
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "created_at", precision: nil, null: false
    t.boolean "global", default: false
    t.datetime "expires", precision: nil
    t.index ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id"
    t.index ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type"
    t.index ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type"
    t.index ["type"], name: "index_mailboxer_notifications_on_type"
  end

  create_table "mailboxer_receipts", id: :serial, force: :cascade do |t|
    t.string "receiver_type"
    t.integer "receiver_id"
    t.integer "notification_id", null: false
    t.boolean "is_read", default: false
    t.boolean "trashed", default: false
    t.boolean "deleted", default: false
    t.string "mailbox_type", limit: 25
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "is_delivered", default: false
    t.string "delivery_method"
    t.string "message_id"
    t.index ["notification_id"], name: "index_mailboxer_receipts_on_notification_id"
    t.index ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type"
  end

  create_table "matter_approvals", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "approve_by_role"
    t.string "status"
    t.integer "matter_intake_id"
    t.integer "approval_sequence"
    t.string "approval_type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "message"
  end

  create_table "matter_intake_attachments", id: :serial, force: :cascade do |t|
    t.integer "matter_intake_id"
    t.string "doc_type"
    t.string "file"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "matter_intakes", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "submitter_name"
    t.string "lob_contact_name"
    t.string "name_of_matter_client"
    t.integer "matter_type_id"
    t.text "matter_description"
    t.string "mode_of_payment"
    t.integer "law_firm_id"
    t.string "bmo_lawyer_name"
    t.integer "lawyer_id"
    t.string "budget_amount"
    t.integer "lxp_id"
    t.string "lob_contact_for_po"
    t.string "cost_centre_for_legal_fees"
    t.string "paying_entity"
    t.string "business_paying_for_matter"
    t.string "group_paying_for_matter"
    t.string "status"
    t.datetime "lob_submitted_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "legal_group_of_bmo_lawyer"
    t.string "work_area"
    t.string "is_ore_reportable"
    t.string "is_otherwise_reportable"
    t.string "is_syndicate_matter"
    t.string "is_conceal_imanage_workspace"
    t.string "is_paper_file"
    t.string "jurisdiction"
    t.string "firm_type"
    t.string "name_of_panel_firm"
    t.string "name_of_non_panel_firm"
    t.string "type_of_price"
    t.string "is_alternative_fee_arrangement"
    t.string "afa_details"
    t.string "additional_matter_contact"
    t.string "other_matter_issues"
    t.datetime "lawyer_reviewed_at", precision: nil
    t.string "other_party"
    t.string "matter_number"
    t.datetime "lxp_reviewed_at", precision: nil
    t.string "form_type"
    t.string "branch"
    t.string "outside_counsel_engaged"
    t.string "can_reimbursed_matter"
    t.text "key_facts"
    t.string "legal_analysis"
    t.string "stage_of_litigation"
    t.string "allegation_of_employee_misconduct"
    t.string "primary_issue"
    t.string "secondary_issue"
    t.string "bmo_party"
    t.string "opposing_counsel_firm"
    t.boolean "written_legal_notice_required", default: false
    t.string "arbitration_offered"
    t.string "arbitration_accepted"
    t.string "branch_manager_investment_advisor"
    t.date "date_suit_filed"
    t.string "unquantified_claim"
    t.string "valued_at"
    t.string "amount_claimed_from_bmo_1"
    t.string "amount_claimed_1_currency"
    t.string "amount_claimed_from_bmo_2"
    t.string "amount_claimed_2_currency"
    t.string "amount_claimed_by_bmo"
    t.string "amount_claimed_by_bmo_currency"
    t.string "breakdown_of_claim_amount"
    t.string "court_name"
    t.string "case_caption"
    t.string "docket_number"
    t.string "comset_issues"
    t.string "comset_ref"
    t.string "mi_matter"
    t.string "region_name"
    t.string "nature_of_events"
    t.string "process_type_level_1"
    t.string "process_type_level_2"
    t.string "product_type_level_1"
    t.string "product_type_level_2"
    t.string "event_type_level_1"
    t.string "event_type_level_2"
    t.string "business_activity_level_1"
    t.string "business_activity_level_2"
    t.string "court_type"
    t.string "following_matter_involve"
    t.string "deal_code"
    t.string "work_area_type"
    t.string "additional_comments_for_lrc_lawyer"
    t.string "who_requires_access_to_imanage_workspace"
    t.boolean "email_notification_to_litigation_specialist_team", default: false
    t.string "asset"
    t.string "receive_personal_information"
    t.string "receive_general_business_data"
    t.string "applicable_technical_specialty_data"
    t.text "receive_personal_information_data_type"
    t.text "receive_general_business_data_type"
    t.text "applicable_technical_specialty_data_type"
    t.string "reviewer_email"
    t.integer "requested_by_id"
    t.string "related_matter_number"
    t.boolean "pii_involved"
    t.string "internal_file_number"
    t.string "business_department"
    t.string "business_group"
    t.integer "line_of_business_id"
    t.datetime "deleted_at", precision: nil
    t.string "assign_lawyer"
  end

  create_table "matter_types", id: :serial, force: :cascade do |t|
    t.string "matter_type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "notes", id: :serial, force: :cascade do |t|
    t.integer "law_firm_id"
    t.string "message_type"
    t.text "message"
    t.string "step"
    t.integer "admin_user_id"
    t.string "sender"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "form_submission_id"
    t.integer "follow_up_id"
    t.datetime "deleted_at", precision: nil
  end

  create_table "panel_requests", id: :serial, force: :cascade do |t|
    t.string "requested_by"
    t.integer "user_id"
    t.string "submitted_by_email"
    t.string "line_of_business"
    t.string "lob_contact_name"
    t.integer "law_firm_id"
    t.string "request_type"
    t.string "law_firm_category"
    t.string "minority_owned"
    t.text "minority_owned_details"
    t.string "women_owned"
    t.text "women_owned_details"
    t.string "matter_name"
    t.text "matter_types"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "law_firm_name"
    t.string "business_manager_name"
    t.string "business_manager_phone"
    t.string "business_manager_email"
    t.string "status"
    t.string "lxp_status"
    t.integer "lxp_id"
    t.string "docusign_envelope_id"
    t.text "notes"
    t.string "niche_preferred_external_counsel_panel_law_firms"
    t.text "niche_expertise"
    t.string "required_unique_geography"
    t.text "geographic_location"
    t.string "involved_engagement"
    t.text "reason_other"
    t.string "law_frim_name"
    t.string "law_firm_contact_name"
    t.string "law_firm_mail"
    t.string "law_firm_role"
    t.string "law_firm_phone"
    t.string "firm_use_on_regular_basis"
    t.datetime "archived_at", precision: nil
  end

  create_table "proposal_comments", force: :cascade do |t|
    t.integer "proposal_id"
    t.integer "user_id"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proposals", force: :cascade do |t|
    t.integer "rfp_id"
    t.integer "user_id"
    t.integer "law_firm_id"
    t.float "amount"
    t.text "description"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer "rfp_id"
    t.text "message"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "queued_notifications", id: :serial, force: :cascade do |t|
    t.datetime "trigger_at", precision: nil
    t.integer "trigger_id"
    t.integer "action_item_id"
    t.boolean "triggered", default: false
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.float "severity_negative_factor"
    t.index ["deleted_at"], name: "index_queued_notifications_on_deleted_at"
  end

  create_table "reviews", id: :serial, force: :cascade do |t|
    t.integer "reviewable_id"
    t.string "reviewable_type"
    t.string "status"
    t.string "status_from"
    t.text "description"
    t.integer "actor_id"
    t.integer "assigned_to_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "pay_type"
    t.text "retainer_cover"
    t.string "law_firm_id"
  end

  create_table "rfp_invites", force: :cascade do |t|
    t.integer "rfp_id"
    t.integer "user_id"
    t.integer "law_firm_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rfp_lobs", force: :cascade do |t|
    t.integer "user_id"
    t.integer "rfp_id"
    t.string "role"
    t.boolean "notify"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rfps", force: :cascade do |t|
    t.integer "matter_intake_id"
    t.integer "user_id"
    t.datetime "expiry_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "security_alerts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "severity"
    t.string "link"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "alert_date", precision: nil
  end

  create_table "security_threats", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "severity_level_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.float "severity_negative_factor"
    t.text "vendor"
    t.text "platform"
    t.text "version"
    t.text "service_pack"
  end

  create_table "severity_levels", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "shared_bank_informations", id: :serial, force: :cascade do |t|
    t.integer "form_value_id"
    t.string "name"
    t.string "purpose"
    t.string "level_of_access"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "states", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "iso"
    t.integer "country_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "sub_matter_types", id: :serial, force: :cascade do |t|
    t.string "sub_matter_type"
    t.integer "matter_type_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "system_settings", id: :serial, force: :cascade do |t|
    t.float "score_threshold"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "docusign_access_token"
    t.text "docusign_refresh_token"
    t.datetime "docusign_token_expires_at", precision: nil
    t.string "lxp_name", default: ""
    t.string "lxp_email", default: ""
    t.string "panel_status", default: "No"
  end

  create_table "technologies", id: :serial, force: :cascade do |t|
    t.string "vendor"
    t.string "platform"
    t.string "version"
    t.string "service_pack"
    t.string "supported"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "platform_category"
    t.string "platform_type"
    t.index ["platform", "version"], name: "index_technologies_on_platform_and_version"
    t.index ["vendor", "platform"], name: "index_technologies_on_vendor_and_platform"
    t.index ["vendor"], name: "index_technologies_on_vendor"
    t.index ["version", "service_pack"], name: "index_technologies_on_version_and_service_pack"
  end

  create_table "technology_values", id: :serial, force: :cascade do |t|
    t.string "platform_category"
    t.string "platform_type"
    t.string "vendor"
    t.string "platform"
    t.string "version"
    t.string "service_pack"
    t.string "supported"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "law_firm_id"
    t.integer "form_submission_id"
    t.integer "technology_id"
    t.boolean "checked", default: false
  end

  create_table "tenant_matter_approvals", id: :serial, force: :cascade do |t|
    t.string "approval_type"
    t.string "owner_role"
    t.string "role"
    t.boolean "approval"
    t.boolean "notification"
    t.integer "tenant_id"
    t.string "title"
    t.integer "sequence_number"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "tenant_questions", force: :cascade do |t|
    t.integer "tenant_id"
    t.text "title"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tenants", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.string "logo"
    t.string "primary_color"
    t.string "secondary_color"
    t.string "login_bg_image"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "okta_client_id"
    t.string "okta_client_secret"
    t.string "okta_site"
    t.string "okta_api_token"
    t.string "sso_type"
    t.string "azure_client_id"
    t.string "azure_client_secret"
    t.string "azure_tenant_id"
    t.string "internal_lawyer"
    t.string "master_user"
    t.string "business_user"
    t.string "retainer_template_id"
    t.string "panel_retainer_template_id"
    t.integer "auto_approve_amount_limit"
    t.string "auto_approve_matter_type"
    t.string "matter_first_approval"
    t.string "matter_second_approval"
    t.string "matter_third_approval"
    t.string "approval_process"
    t.string "matter_optional_fields"
    t.boolean "enable_exception_requests", default: true
    t.string "internal_lawyer_label"
    t.boolean "allow_panel_consideration_lob_Lawyers"
    t.string "system_score_threshold"
    t.boolean "rfp_enable"
  end

  create_table "third_party_vendors", id: :serial, force: :cascade do |t|
    t.integer "form_value_id"
    t.string "vendor_name"
    t.string "area"
    t.string "confidentiality_agreement"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "todo_tasks", id: :serial, force: :cascade do |t|
    t.integer "law_firm_id"
    t.string "title"
    t.string "message"
    t.string "severity"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "triggers", id: :serial, force: :cascade do |t|
    t.integer "hours"
    t.string "action_type"
    t.string "message"
    t.integer "severity_level_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deactivated_at", precision: nil
    t.string "otp_secret_key"
    t.string "google_secret"
    t.string "role"
    t.integer "law_firm_id"
    t.boolean "new_password_set", default: false
    t.datetime "qr_code_confirmed_at", precision: nil
    t.string "first_name"
    t.string "last_name"
    t.string "line_of_business"
    t.string "lob_contact_name"
    t.string "two_fa_key"
    t.datetime "two_fa_key_expires_at", precision: nil
    t.string "status"
    t.string "provider"
    t.string "provider_uid"
    t.string "provider_group"
    t.integer "tenant_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "values", id: :serial, force: :cascade do |t|
    t.integer "law_firm_id"
    t.integer "values_id"
    t.string "value"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "vendors", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "vendor_type"
    t.string "application"
    t.integer "form_value_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at", precision: nil
    t.text "object_changes"
    t.string "message"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
end
