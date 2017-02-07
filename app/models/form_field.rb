class FormField < ApplicationRecord

  acts_as_sortable do |config|
    config[:relation] = ->(instance) {instance.class.base_class}
  end

  belongs_to :formable, polymorphic: true
  belongs_to :form

  belongs_to :parent, :class_name => 'FormField'
  has_many   :children, ->{ordered_by_position_asc}, :class_name => 'FormField', :foreign_key => 'parent_id'
  has_many   :dropdown_options

  validates :type, presence: true

  scope :top_form_fields, -> { where(parent_id: nil).ordered_by_position_asc }

  accepts_nested_attributes_for :dropdown_options, allow_destroy: true
  accepts_nested_attributes_for :children

  def validate_value(form_value)
    form_value.errors.add :value, "can't be blank" if required? && form_value.value.blank?

    add_validation_errors(form_value)
    form_value
  end

  def get_step
    step = 0
    obj = self
    while !obj.parent.nil?
      step += 1
      obj = obj.parent
    end
    return step
  end

  def add_validation_errors(form_value)
    fail NotImplementedError
  end

end
