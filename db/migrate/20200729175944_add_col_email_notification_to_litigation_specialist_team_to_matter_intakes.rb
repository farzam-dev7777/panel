class AddColEmailNotificationToLitigationSpecialistTeamToMatterIntakes < ActiveRecord::Migration[5.0]
  def change
    add_column :matter_intakes, :email_notification_to_litigation_specialist_team, :boolean, default: false
  end
end
