ActiveAdmin.register LawFirm do
  permit_params :name, :email, :phone, :description, :temp_password

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :phone
    column :created_at
    actions
  end

  filter :email
  filter :name
  filter :phone
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :email
      f.input :phone
      f.input :description
      f.input :temp_password if f.object.new_record?
    end
    f.actions
  end


end
