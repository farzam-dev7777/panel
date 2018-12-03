class UploadField < FormField

	FILES_LIMIT = 2

  def as
    :file
  end
end