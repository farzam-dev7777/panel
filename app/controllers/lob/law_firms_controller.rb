class Lob::LawFirmsController < Lob::BaseController

  layout 'lob'

  add_breadcrumb "Dashboard", :root_path

  def panel_law_firms
    @q = LawFirm.includes(:locations).ransack(params[:q])
    law_firm_ids = LawFirmsTenant.where(tenant_id: Tenant.current&.id).pluck(:law_firm_id)
    @law_firms = @q.result(distinct: true).where(law_firm_category: "PANEL", id: law_firm_ids).order('created_at DESC')
    # @law_firms =  LawFirm.where(law_firm_category: "PANEL")

    @params_string = false;
    if !params[:q].nil?
      @params_string =  params[:q][:name_cont]&.empty? && params[:q][:locations_country_cont]&.empty? && params[:q][:panel_status_eq]&.empty? ? false : true
    end 
    add_breadcrumb "Law Firms", :admin_law_firms_path
    render "admin/law_firms/panel_law_firms"
  end

end
