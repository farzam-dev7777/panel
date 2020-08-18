class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :actor, class_name: 'User'
  belongs_to :assigned_to, class_name: 'User'

  after_save :update_reviewable_status

  attr_accessor :pay_type
  
  def update_reviewable_status
    if self.reviewable.class.to_s === 'ConflictWaiver'
      if self.actor.role === 'lxp';
        self.reviewable.lxp_status = self.status
        if self.status === 'APPROVED'
           self.reviewable.assigned_to_id = self.assigned_to_id
          
        end
      elsif self.actor.role === 'internal_lawyers'
        self.reviewable.internal_lawyers_status = self.status.blank? ? self.reviewable.internal_lawyers_status : self.status
      end
    end
    if self.reviewable.class.to_s === 'ExceptionRequest'
      if self.actor.role === 'lxp';
        self.reviewable.lxp_status = self.status
        self.reviewable.lxp_id = self.actor_id
        if self.assigned_to_id.present?
          self.reviewable.internal_lawyers_id = self.assigned_to_id
        end
        if self.status === 'APPROVED' || self.status.blank?
          
          self.reviewable.pay_type = self.pay_type
          
        end
      elsif self.actor.role === 'internal_lawyers'
        self.reviewable.internal_lawyers_status = self.status.blank? ? self.reviewable.internal_lawyers_status : self.status
        self.reviewable.internal_lawyers_id = self.actor_id
      end
    end
    self.reviewable.save
  end

  def status_show
    if self.status.present?
      if self.reviewable_type == "ExceptionRequest"
        ExceptionRequest::EXCEPTION_REQUEST_STATUS[self.status.to_sym]
      elsif self.reviewable_type == "MatterIntake"
        self.status
      else
        if  ConflictWaiver::CONFLICT_WAIVER_STATUS[self.status.to_sym]
          ConflictWaiver::CONFLICT_WAIVER_STATUS[self.status.to_sym]
        else
          ConflictWaiver::CONFLICT_WAIVER_STATUS_LAWYER[self.status.to_sym]
        end  
      end
    end
   end
end
