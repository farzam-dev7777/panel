class MatterIntakeAttachment < ApplicationRecord
	belongs_to :matter_intake
	mount_uploader :file, FileUploader
end
