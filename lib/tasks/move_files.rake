namespace :move_files do
  task mark_for_deletion: :environment do
    form_submissions = FormSubmission.where(status: "approved")
    form_values = FormValue.where(submittable_type: "FormSubmission", submittable_id: form_submissions.pluck(:id))
    file_attachments = FileAttachment.where(form_value_id: form_values.pluck(:id)) + FileAttachment.where(form_value_id: form_values.pluck(:id)).where(attachable_id: fs.pluck(:id), attachable_type: "FormSubmission")
    file_attachments.map(&:id).each do |fa|
      directory = "/var/www/bluehound/current/public/uploads/file_attachment/file/#{fa}/"
      destination = "/var/www/back-jan15-2019/uploads/file_attachment/file/"
      if File.directory?(directory)
        FileUtils.mv(directory, destination)
      end
    end
  end
end