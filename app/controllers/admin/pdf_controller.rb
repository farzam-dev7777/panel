class Admin::PdfController < Admin::BaseController

	layout false

	def activity_logs
		if params[:id]
			law_firm = LawFirm.find_by(id: params[:id])
			@activity_logs = law_firm.activity_logs
		else
			@activity_logs = ActivityLog.all
		end

		pdf = WickedPdf.new.pdf_from_string(
			render_to_string('admin/pdf/activity_logs.html.erb')
		)
		send_data pdf, :filename => "#{Time.now}.pdf", :type => "application/pdf", :disposition => "attachment"
		
	end

end
