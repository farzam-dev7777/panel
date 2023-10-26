class LawFirmAttachment < ApplicationRecord
	belongs_to :law_firm
	belongs_to :tenant
	mount_uploader :file, FileUploader
end
