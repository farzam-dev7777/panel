module Formable
  extend ActiveSupport::Concern

  included do
    has_many :form_fields, as: :formable
    accepts_nested_attributes_for :form_fields, allow_destroy: true
    has_many :group_form_fields, class_name: GroupFormField

    scope :without, -> (current_field) { where('id NOT IN ?', [current_field]) }
  end
end