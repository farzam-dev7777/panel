class LawFirmsController < BaseController

  load_and_authorize_resource
    
	def edit
		@law_firm = LawFirm.find(params[:id])
	end

	def update
		@law_firm = LawFirm.find(params[:id])
  	if @law_firm.update_attributes(law_firms_params)
  		@law_firm.update_attributes(profile_completed: true)
  		redirect_to root_url
  	else
  		flash[:alert] = "There was an error updating the law firm"
  		render :new
  	end
	end

  private

  def law_firms_params
    params.require(:law_firm).permit(:name, :description, :email, :phone, :temp_password, :relationship_manager_email, :law_firm_type, :principle_name, :principle_title, :principle_contact_info, :parent_company, :sister_firm, locations_attributes: [:id, :address1, :address2, :city, :province, :postal_code, :country, :_destroy], jurisdictions_attributes: [:id, :country, :_destroy,  city: []], practice_area: [])
  end

end
