class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def okta
    @user = User.from_omniauth_okta(request.env["omniauth.auth"])
    session[:oktastate] = request.env["omniauth.auth"]["uid"]
    if @user&.id.present?
      @user.reload
      sign_in @user
      if (@user.role == 'superadmin' || @user.role == 'admin' || @user.is_panel_admin_user?)
        if current_user.role == "lob"
          redirect_to lob_root_url
        else
          redirect_to admin_root_url
        end
      else
        redirect_to root_path
      end
    else
      flash[:notice] = "Error authenticating! Please ensure user have permission to access."
      redirect_to new_user_session_path
    end
  end

  def azure_activedirectory_v2
    @user = User.from_omniauth_azure(request.env["omniauth.auth"])
    if @user&.id.present?
      @user.reload
      sign_in @user
      if (@user.role == 'superadmin' || @user.role == 'admin' || @user.is_panel_admin_user?)
        if current_user.role == "lob"
          redirect_to lob_root_url
        else
          redirect_to admin_root_url
        end
      else
        redirect_to root_path
      end
    else
      flash[:notice] = "Error authenticating! Please ensure user have permission to access."
      redirect_to new_user_session_path
    end
  end
end