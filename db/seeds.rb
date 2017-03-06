# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Law Firms
law_firm = LawFirm.create!(name: "Preszler Law Firm",
													 description: "Personal Injury Attorney",
													 email: "presezlerlawfirm@seal-test.com",
												 	 phone: "+1 888-608-2111",
									 				 temp_password: 'se123456al')
law_firm.log_activity('account_created', true)

law_firm = LawFirm.create!(name: "Niren & Associates Immigration Law Firm",
													 description: "Immigration Attorney",
													 email: "nirenassociatesimmigrationlawfirm@seal-test.com",
												 	 phone: "+1 416 410 7484",
									 				 temp_password: 'se123456al')
law_firm.log_activity('account_created', true)

law_firm = LawFirm.create!(name: "E&A Law Firm - Toronto Family Law Attorney",
													 description: "Child Support Lawyers",
													 email: "ealawfirm@seal-test.com",
												 	 phone: "+1 416 777 2216",
									 				 temp_password: 'se123456al')
law_firm.log_activity('account_created', true)

law_firm = LawFirm.create!(name: "Shulman Law Firm",
													 description: "Family Law Attorney",
													 email: "shulmanlawfirm@seal-test.com",
												 	 phone: "+1 416 661 2777",
									 				 temp_password: 'se123456al')
law_firm.log_activity('account_created', true)

law_firm = LawFirm.create!(name: "Kahler Personal Injury Law Firm",
													 description: "Personal Injury Attorney",
													 email: "kahlerlawfirm@seal-test.com",
												 	 phone: "+1 888-608-2111",
									 				 temp_password: 'se123456al')
law_firm.log_activity('account_created', true)

law_firm = LawFirm.create!(name: "Worsoff Law Firm",
													 description: "",
													 email: "worsofflawfirm@seal-test.com",
												 	 phone: "+1 (416) 423-3333",
									 				 temp_password: 'se123456al')
law_firm.log_activity('account_created', true)

law_firm = LawFirm.create!(name: "Borders Law Firm Immigration Lawyers",
													 description: "Immigration Attorney",
													 email: "borderslaw_firm@seal-test.com",
												 	 phone: "+1 (416) 481-5689",
									 				 temp_password: 'se123456al')
law_firm.log_activity('account_created', true)

law_firm = LawFirm.create!(name: "Wires Law",
													 description: "Attorney",
													 email: "wireslawfirm@seal-test.com",
												 	 phone: "+1 (416) 549-5922",
									 				 temp_password: 'se123456al')
law_firm.log_activity('account_created', true)

law_firm = LawFirm.create!(name: "The Law Firm of Ted Yoannou",
													 description: "Criminal Justice Attorney",
													 email: "tedyoannoulawfirm@seal-test.com",
												 	 phone: "+1 (416) 650-1011",
									 				 temp_password: 'se123456al')
law_firm.log_activity('account_created', true)

law_firm = LawFirm.create!(name: "Kruse Law",
													 description: "Criminal Justice Attorney",
													 email: "kruselawfirm@seal-test.com",
												 	 phone: "+1 (416) 900-3889",
									 				 temp_password: 'se123456al')
law_firm.log_activity('account_created', true)

