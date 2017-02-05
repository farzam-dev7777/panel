class ProgramRegistrationsController
  include SubmissionBehaviors

  def program_registration_params
    form_submission_attributes = [:id]
    params.require(:form_submission).permit(form_submission_attributes + form_values_attributes)
  end
end