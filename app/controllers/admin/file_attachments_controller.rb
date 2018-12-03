class Admin::FileAttachmentsController < Admin::BaseController

  def decrypt
    @file_attachment = FileAttachment.find(params[:id])
    # send_file @file_attachment.decrypt(params[:key]), filename: @file_attachment.try(:file).try(:file).try(:filename)

    file = @file_attachment.decrypt(params[:key])
    render json: { 
    	file: Base64.encode64(File.open(file.path, "rb").read), 
  		filename: @file_attachment.try(:file).try(:file).try(:filename) 
  	}
  end

end
