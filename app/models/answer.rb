class Answer < ApplicationRecord
	belongs_to :question
	belongs_to :rfp
	belongs_to :proposal

	mount_uploader :file, FileUploader
end
