class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  after_action :track_login, only: [:create]

  layout 'login'
  skip_before_action :verify_authenticity_token

  def track_login
    begin
      $tracker.people.set(current_law_firm && current_law_firm.name, {
        '$firstname'                   => current_law_firm && current_law_firm.name,
        '$lastname'                    => current_law_firm && current_law_firm.name,
        '$username'                    => current_law_firm && current_law_firm.name,
        '$email'                       => current_law_firm && current_law_firm.name,
        '$law_firm'                    => current_law_firm && current_law_firm.name,
        '$initial_date_of_engagement'  => current_law_firm && current_law_firm.initial_date_of_engagement_with_the_bank,
        '$type_of_matters_your_law_firm_handles_for_us'  => current_law_firm && current_law_firm.type_of_matters_your_law_firm_handles_for_us.reject(&:empty?),
        '$number_of_lawyers'  => current_law_firm && current_law_firm.number_of_lawyers,
        '$locations'  => current_law_firm && current_law_firm.locations.map(&:country),
      }, ip = request.env.fetch("REMOTE_ADDR", nil), 
      {'$ignore_time' => 'true'});
      $tracker.people.increment(current_law_firm && current_law_firm.name, {
       'Login' => 1
      })
      $tracker.track(current_law_firm && current_law_firm.name, 'Login', {
        'username' => current_user.username
      })
    rescue Exception => e
      Rollbar.log('error', e)
    end
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
    session[:oktastate] = nil
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
