class Form < ApplicationRecord
  include Formable
  amoeba do
    enable
  end

  STEPS = ['policy', 'process']

  has_many :logics

  def all_logics(reload = false)
    @all_logics = nil if reload
    @all_logics ||= (
      @all_logics = self.logics
      @all_logics.merge(self.group_forms.map(&:logics).flatten)
    )
  end

  def group_forms
    Form.where(id: self.form_fields.where("group_form_id IS NOT NULL").pluck(:group_form_id))
  end

  def group_form_fields
    FormField.where(formable_id: self.form_fields.where("group_form_id IS NOT NULL").pluck(:group_form_id), formable_type: "Form")
  end

  def all_form_fields(reload = false)
    @all_form_fields = nil if reload
    @all_form_fields ||= (
      @all_form_fields = self.form_fields
      @all_form_fields.merge(self.group_forms.map(&:form_fields).flatten)
    )
  end

end
