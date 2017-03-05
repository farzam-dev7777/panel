# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170303203525) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "activity_logs", force: :cascade do |t|
    t.integer  "law_firm_id"
    t.string   "event_type"
    t.string   "custom_message"
    t.string   "loggable_type"
    t.integer  "loggable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "read"
    t.boolean  "notify"
    t.index ["loggable_type", "loggable_id"], name: "index_activity_logs_on_loggable_type_and_loggable_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "dropdown_options", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "form_field_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.float    "score",         default: 0.0
  end

  create_table "file_attachments", force: :cascade do |t|
    t.string   "file"
    t.integer  "form_value_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "follow_ups", force: :cascade do |t|
    t.integer  "form_submission_id"
    t.string   "loggable_type"
    t.integer  "loggable_id"
    t.string   "status"
    t.integer  "note_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "form_fields", force: :cascade do |t|
    t.string   "min"
    t.string   "max"
    t.boolean  "required"
    t.string   "label"
    t.string   "type"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "form_id"
    t.integer  "formable_id"
    t.string   "formable_type"
    t.integer  "parent_id"
    t.integer  "position"
    t.integer  "group_form_id"
    t.boolean  "repeater"
    t.boolean  "custom_logic"
    t.integer  "show_when_form_field_id"
    t.string   "show_when_form_field_value"
    t.boolean  "scored"
    t.float    "score"
    t.index ["position"], name: "index_form_fields_on_position", using: :btree
  end

  create_table "form_submissions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "form_id"
    t.integer  "form_process_id"
    t.boolean  "submitted",       default: false
    t.datetime "submitted_on"
    t.integer  "law_firm_id"
    t.float    "score"
    t.string   "status"
  end

  create_table "form_values", force: :cascade do |t|
    t.integer  "form_field_id"
    t.integer  "submittable_id"
    t.string   "value"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "submittable_type"
    t.string   "form_field_label"
    t.string   "file_value"
    t.boolean  "checked",          default: false
  end

  create_table "forms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "group_form"
    t.string   "step"
  end

  create_table "history_submissions", force: :cascade do |t|
    t.string   "incident_type"
    t.string   "impact"
    t.string   "discovery_time"
    t.string   "source"
    t.string   "data_loss"
    t.text     "incident_details"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "form_submission_id"
    t.boolean  "checked",            default: false
  end

  create_table "law_firms", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.string  "unsubscriber_type"
    t.integer "unsubscriber_id"
    t.integer "conversation_id"
    t.index ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
    t.index ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree
  end

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.string   "sender_type"
    t.integer  "sender_id"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.string   "notified_object_type"
    t.integer  "notified_object_id"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
    t.index ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
    t.index ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
    t.index ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
    t.index ["type"], name: "index_mailboxer_notifications_on_type", using: :btree
  end

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.string   "receiver_type"
    t.integer  "receiver_id"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "is_delivered",               default: false
    t.string   "delivery_method"
    t.string   "message_id"
    t.index ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
    t.index ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "law_firm_id"
    t.string   "message_type"
    t.text     "message"
    t.string   "step"
    t.integer  "admin_user_id"
    t.string   "sender"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "form_submission_id"
    t.integer  "follow_up_id"
  end

  create_table "security_alerts", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "severity"
    t.string   "link"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "technologies", force: :cascade do |t|
    t.string   "vendor"
    t.string   "platform"
    t.string   "version"
    t.string   "service_pack"
    t.string   "supported"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "technology_values", force: :cascade do |t|
    t.string   "platform_category"
    t.string   "platform_type"
    t.string   "vendor"
    t.string   "platform"
    t.string   "version"
    t.string   "service_pack"
    t.string   "supported"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "law_firm_id"
    t.integer  "form_submission_id"
    t.integer  "technology_id"
    t.boolean  "checked",            default: false
  end

  create_table "todo_tasks", force: :cascade do |t|
    t.integer  "law_firm_id"
    t.string   "title"
    t.string   "message"
    t.string   "severity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
end
