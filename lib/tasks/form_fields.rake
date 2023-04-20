namespace :form_fields do
  desc "TODO"
  task capitalize_form_field_labels: :environment do
  	form_fields = FormField.all
  	form_fields.each do |field|
  		field.update(label: field.label.capitalize)
  	end
  	puts "Form Fields capitalized"
  	
  	groupform_fields = GroupFormField.all
  	groupform_fields.each do |field|
  		field.update(label: field.label.capitalize)
  	end
  	puts "Group Form Fields capitalized"
  end

end
