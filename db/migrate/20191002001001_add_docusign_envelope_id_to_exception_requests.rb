class AddDocusignEnvelopeIdToExceptionRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :exception_requests, :docusign_envelope_id, :string
  end
end
