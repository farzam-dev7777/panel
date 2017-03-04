# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

# Policy Form
# @policy_form = Form.new(name: "Policy", step: 'policy')
# @policy_form.save

# field = FormField.new(label: "DO YOU HAVE AN ACTIVE INFORMATION SECURITY POLICY?", 
# 											formable_id: @policy_form.id,
# 											formable_type: 'Form')