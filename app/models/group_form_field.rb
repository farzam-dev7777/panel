class GroupFormField < FormField
  belongs_to :group_form, class_name: "Form"
end
