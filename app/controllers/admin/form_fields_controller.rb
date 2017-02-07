class FormFieldsController < ApplicationController
  def move
    @form_field = FormField.find(params[:id])
    @form_field.move_to! params[:position]
  end
end