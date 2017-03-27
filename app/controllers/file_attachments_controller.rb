class FileAttachmentsController < BaseController

  def create
    @object = params[:type].constantize.find(params[:id])
    @file_attachments = []
    params[:files].each do |file|
      @file_attachments.push(build_file_attachment(file, @object))
    end
    render(partial: 'file_attachment', locals: { file_attachments: @file_attachments })
  end

  def destroy
    @file_attachment = FileAttachment.find(params[:id])
    authorize! :destroy, @file_attachment
    @file_attachment.destroy
    render json: @file_attachment.id
  end

  def decrypt
    @file_attachment = FileAttachment.find(params[:id])
    authorize! :destroy, @file_attachment
    send_file @file_attachment.decrypt
  end

  private

  def build_file_attachment(file, obj)
    file_attachment = obj.file_attachments.build
    authorize! :create, file_attachment
    file_attachment.file = file
    file_attachment.save && file_attachment
  end

end
