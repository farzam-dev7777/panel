module HasAttachedFiles
  extend ActiveSupport::Concern
  attr_accessor :file_ids

  included do
    before_save :attach_files_to_object
  end

  def attach_files_to_object
    if !self.file_ids.blank?
  		file_attachment_ids = self.file_ids
      self.file_ids = nil
  		file_attachments = ::FileAttachment.where(id: file_attachment_ids)
  		file_attachments.each do |file_attachment|
        next if file_attachment.attachable
        file_attachment.update_attributes(attachable: self, form_value_id: self.form_value_id)
  		end
  	end
  end
end