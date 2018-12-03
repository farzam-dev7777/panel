class FileAttachmentsController < BaseController

  def create
    if(params[:type])
      @object = params[:type].constantize.find(params[:id])
      @file_attachments = []
      params[:files].each do |file|
        @file_attachments.push(build_file_attachment(file, @object))
      end
    else
      @file_attachments = []
      params[:files].each do |file|
        @file_attachments << FileAttachment.create(file: file)
      end
    end
    render json: { file_attachment: @file_attachments, 
                   file_attachment_ids: @file_attachments.map(&:id), 
                   file_attachment_html: render_to_string('/application/_file_attachment', layout: false, locals: { file_attachments: @file_attachments }) }
    # render(partial: 'file_attachment', locals: { file_attachments: @file_attachments })
  end

  def destroy
    @file_attachment = FileAttachment.find(params[:id])
    authorize! :destroy, @file_attachment
    @file_attachment.destroy
    render json: @file_attachment.id
  end

  private

  def build_file_attachment(file, obj)
    file_attachment = obj.file_attachments.build(form_value_id: obj.try(:form_value_id))
    authorize! :create, file_attachment
    file_attachment.file = file
    file_attachment.save && file_attachment
  end

end
