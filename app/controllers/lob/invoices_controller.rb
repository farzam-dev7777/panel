class Lob::InvoicesController < Lob::BaseController

  layout 'lob'

  def index
    @matter_intakes = MatterIntake.where("line_of_business_id in (?) OR user_id = ?", current_user.line_of_businesses.pluck(:id), current_user.id).order('updated_at DESC')
    @invoices = @matter_intakes.map(&:invoices).flatten
  end

end