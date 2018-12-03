class PdfController < BaseController

	def activity_logs
		@activity_logs = current_law_firm.activity_logs
		respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{current_law_firm.id}_activities"
      end
    end
	end

end
