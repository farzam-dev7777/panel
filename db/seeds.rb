# Law Firms

# law_firm = LawFirm.create!(name: "Alston & Bird LLP",description: "Law Firm",email: "alisonandbird@seal-test.com",phone: "+1 212-210-9400", temp_password: 'password')
# law_firm.log_activity('account_created', true, User.find_by(role: 'superadmin'))

# law_firm = LawFirm.create!(name: "The Lanier Law Firm PLLC",description: "Law Firm",email: "lanier@seal-test.com",phone: "+1 212-210-9400", temp_password: 'password')
# law_firm.log_activity('account_created', true, User.find_by(role: 'superadmin'))

# law_firm = LawFirm.create!(name: "The Blanch Law Firm",description: "Law Firm",email: "blanch@seal-test.com",phone: "+1 212-210-9400", temp_password: 'password')
# law_firm.log_activity('account_created', true, User.find_by(role: 'superadmin'))

# law_firm = LawFirm.create!(name: "Spodek Criminal Defense Lawyers",description: "Law Firm",email: "spodek@seal-test.com",phone: "+1 212-210-9400", temp_password: 'password')
# law_firm.log_activity('account_created', true, User.find_by(role: 'superadmin'))

# law_firm = LawFirm.create!(name: "Cary Kane LLP",description: "Law Firm",email: "carykane@seal-test.com",phone: "+1 212-210-9400", temp_password: 'password')
# law_firm.log_activity('account_created', true, User.find_by(role: 'superadmin'))

# law_firm = LawFirm.create!(name: "Preszler Law Firm",description: "Personal Injury Attorney",email: "presezlerlawfirm@seal-test.com",phone: "+1 888-608-2111", temp_password: 'password')
# law_firm.log_activity('account_created', true, User.find_by(role: 'superadmin'))

# law_firm = LawFirm.create!(name: "Niren & Associates Immigration Law Firm",description: "Immigration Attorney",email: "nirenassociatesimmigrationlawfirm@seal-test.com",phone: "+1 416 410 7484", temp_password: 'password')
# law_firm.log_activity('account_created', true, User.find_by(role: 'superadmin'))

# law_firm = LawFirm.create!(name: "E&A Law Firm - Toronto Family Law Attorney",description: "Child Support Lawyers",email: "ealawfirm@seal-test.com",phone: "+1 416 777 2216", temp_password: 'password')
# law_firm.log_activity('account_created', true, User.find_by(role: 'superadmin'))

# law_firm = LawFirm.create!(name: "Shulman Law Firm",description: "Family Law Attorney",email: "shulmanlawfirm@seal-test.com",phone: "+1 416 661 2777", temp_password: 'password')
# law_firm.log_activity('account_created', true, User.find_by(role: 'superadmin'))

# law_firm = LawFirm.create!(name: "Kahler Personal Injury Law Firm",description: "Personal Injury Attorney",email: "kahlerlawfirm@seal-test.com",phone: "+1 888-608-2111", temp_password: 'password')
# law_firm.log_activity('account_created', true, User.find_by(role: 'superadmin'))

# law_firm = LawFirm.create!(name: "Worsoff Law Firm",description: "",email: "worsofflawfirm@seal-test.com",phone: "+1 (416) 423-3333", temp_password: 'password')
# law_firm.log_activity('account_created', true, User.find_by(role: 'superadmin'))

# law_firm = LawFirm.create!(name: "Borders Law Firm Immigration Lawyers",description: "Immigration Attorney",email: "borderslaw_firm@seal-test.com",phone: "+1 (416) 481-5689", temp_password: 'password')
# law_firm.log_activity('account_created', true, User.find_by(role: 'superadmin'))

# law_firm = LawFirm.create!(name: "Wires Law",description: "Attorney",email: "wireslawfirm@seal-test.com",phone: "+1 (416) 549-5922", temp_password: 'password')
# law_firm.log_activity('account_created', true, User.find_by(role: 'superadmin'))

# law_firm = LawFirm.create!(name: "The Law Firm of Ted Yoannou",description: "Criminal Justice Attorney",email: "tedyoannoulawfirm@seal-test.com",phone: "+1 (416) 650-1011", temp_password: 'password')
# law_firm.log_activity('account_created', true, User.find_by(role: 'superadmin'))

# law_firm = LawFirm.create!(name: "Kruse Law",description: "Criminal Justice Attorney",email: "kruselawfirm@seal-test.com",phone: "+1 (416) 900-3889", temp_password: 'password')
# law_firm.log_activity('account_created', true, User.find_by(role: 'superadmin'))

# rails g model severity_levels name:string color:string
# rails g model triggers hours:integer action_type:string message:string severity_level_id:integer
# rails g model security_threats title:string description:text severity_level_id:integer
# rails g model action_items security_threat_id:integer law_firm_id:integer
# rails g model queued_notifications trigger_at:datetime trigger_id:integer action_item_id:integer

# Seed security levels
# severity_levels = [
# 	{ name: 'critical', color: 'red' },
# 	{ name: 'high', color: 'yellow' },
# 	{ name: 'low', color: 'orange' }
# ]
# severity_levels.each do |s|
# 	SeverityLevel.create!(name: s[:name], color: s[:color])
# end

# # Seed Triggers
# critical_severity_level = SeverityLevel.find_by(name: 'critical')
# Trigger.create!(hours: 48, action_type: 'send_notification_to_law_firm', message: 'ALERT!', severity_level_id: critical_severity_level.id)
# Trigger.create!(hours: 72, action_type: 'send_notification_to_law_firm', message: 'ALERT!', severity_level_id: critical_severity_level.id)
# Trigger.create!(hours: 96, action_type: 'send_notification_to_law_firm', message: 'ALERT!', severity_level_id: critical_severity_level.id)

# high_severity_level = SeverityLevel.find_by(name: 'high')
# Trigger.create!(hours: 168, action_type: 'send_notification_to_law_firm', message: 'ALERT!', severity_level_id: high_severity_level.id)
# Trigger.create!(hours: 504, action_type: 'send_notification_to_law_firm', message: 'ALERT!', severity_level_id: high_severity_level.id)


# low_severity_level = SeverityLevel.find_by(name: 'low')
# Trigger.create!(hours: 2190, action_type: 'send_notification_to_law_firm', message: 'ALERT!', severity_level_id: low_severity_level.id)
# Trigger.create!(hours: 4380, action_type: 'send_notification_to_law_firm', message: 'ALERT!', severity_level_id: low_severity_level.id)



