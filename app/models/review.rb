class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :actor, class_name: 'User'
  belongs_to :assigned_to, class_name: 'User'

  after_save :update_reviewable_status
  
  def update_reviewable_status
    binding.pry
    if self.reviewable.class.to_s === 'ConflictWaiver'
      if self.actor.role === 'lxp'
        self.reviewable.lxp_status = self.status
        if self.status === 'approved'
          # self.reviewable.internal_lawyer_id = self.assigned_to_id
        end
      elsif self.actor.role === 'internal_lawyer'
        self.reviewable.internal_lawyers_status = self.status
      end
    end
    self.reviewable.save
  end

end
