class Admin::ReviewsController < Admin::BaseController

  layout 'admin'
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @q = FaqCategory.ransack(params[:q])
    @faq_categories = @q.result(distinct: true).paginate(page: params[:page])
  end
  
  def create
    ActiveRecord::Base.transaction do
      @reviewable = params[:review][:reviewable_type].constantize.find_by(id: params[:review][:reviewable_id])
      status = ""
      if current_user.role === 'lxp'
        if params[:review][:reviewable_type] === "MatterIntake"
          status = params[:review][:status]
        else  
          status = @reviewable.lxp_status  
        end 
      else
        status = @reviewable.internal_lawyers_status
      end
      @review = @reviewable.reviews.build(review_params.merge(
        {
          actor_id: current_user.id,
          pay_type: params[:review][:pay_type],
          status_from: status
        }
      ))

      if @review.save
       
        if params[:review][:reviewable_type] == "ExceptionRequest"
          
          @exception_request = ExceptionRequest.find_by_id(params[:review][:reviewable_id])
          if current_user.role === 'lxp' && review_params[:status] == 'APPROVED'
            # pay type
            @exception_request.update_attributes(lxp_status: review_params[:status])
            @user = User.find_by_id(@exception_request.user_id)
            signer_email = @user.email
            signer_name =  @user.username
            @exception_request.send_retainer_for_esigning(signer_email, signer_name)
            # ExceptionRequestMailer.form_status_notification_to_lob_for_sign(@exception_request).deliver_now
          # elsif current_user.role === 'lxp' &&  review_params[:assigned_to_id].present?
          #   ExceptionRequestMailer.form_status_notification_to_internal_lawyer(@exception_request,params[:review][:assigned_to_id]).deliver_now
          elsif current_user.role === 'lxp' && review_params[:status] == 'SEND_RETAINER_AGREEMENT'
            @exception_request.update_attributes(lxp_status: review_params[:status])
          elsif current_user.role === 'internal_lawyers' && review_params[:status] == 'APPROVED'
            @exception_request.update_attributes(lxp_status: "REVIEWED_BY_LAWYER")
            ExceptionRequestMailer.form_status_notification_to_lxp(@exception_request).deliver_now
          elsif current_user.role === 'lxp' &&  review_params[:status] == 'LAW_FIRM_CREATED'  
            @user = User.new 
            @user.email = @exception_request.law_firm_email
            @user.role = 'master_user'
            @user.empty_user = true
            @user.tenant_id = Tenant.current&.id || current_user&.tenant&.id
            @user.status = nil
            if @user.save
              @law_firm = LawFirm.new
              @law_firm.user_id = @user.id
              @law_firm.law_firm_category = "NON_PANEL"
              @law_firm.name = @exception_request.law_firm_name
              @law_firm.law_firm_category = @exception_request.law_firm_category
              @law_firm.firm_use_on_regular_basis = @exception_request.firm_use_on_regular_basis
              @law_firm.email = @exception_request.law_firm_email
              @law_firm.phone = @exception_request.law_firm_phone
              @law_firm.save
              @exception_request.update_attributes(lxp_status: "APPROVED")
              @exception_request.update_attributes(law_firm_id: @law_firm.id)
              @user.law_firm_id =  @law_firm.id
              @user.save
              @exception_request.lxp_status = 'LAW_FIRM_CREATED'
              begin
                LawFirmsTenant.create(
                  law_firm_id: @law_firm&.id,
                  tenant_id: @user.tenant_id
                )
              rescue => e
              end
              flash[:notice] = "Law Firm Created"
              @review.status = 'LAW_FIRM_CREATED'
              @review.save
              ExceptionRequestMailer.form_status_notification_to_lxp(@exception_request).deliver_now
            else
              @review.status = 'LAW_FIRM_EXIST'
              @review.save
              @exception_request.lxp_status = 'LAW_FIRM_EXIST'
              flash[:alert] = "Law Firm Already Exists"
            end  
            @exception_request.save
          elsif current_user.role === 'lxp' &&  review_params[:status] == 'LAW_FIRM_CREATED_ASSIGN_LAWYER'  
            @user = User.new 
            @user.email = @exception_request.law_firm_email
            @user.role = 'master_user'
            @user.empty_user = true
            @user.tenant_id = Tenant.current&.id || current_user&.tenant&.id
            @user.status = nil
            if @user.save
              @law_firm = LawFirm.new
              @law_firm.user_id = @user.id
              @law_firm.law_firm_category = "NON_PANEL"
              @law_firm.name = @exception_request.law_firm_name
              @law_firm.law_firm_category = @exception_request.law_firm_category
              @law_firm.firm_use_on_regular_basis = @exception_request.firm_use_on_regular_basis
              @law_firm.email = @exception_request.law_firm_email
              @law_firm.phone = @exception_request.law_firm_phone
              @law_firm.save
              @exception_request.update_attributes(lxp_status: "APPROVED")
              @exception_request.update_attributes(law_firm_id: @law_firm.id)
              @user.law_firm_id =  @law_firm.id
              @user.save
              begin
                LawFirmsTenant.create(
                  law_firm_id: @law_firm&.id,
                  tenant_id: @user.tenant_id
                )
              rescue => e
              end
              flash[:notice] = "Law Firm Created and lawyer assigned."
              @review.status = 'LAW_FIRM_CREATED_ASSIGN_LAWYER'
              @review.save
              ExceptionRequestMailer.form_status_notification_to_internal_lawyer(@exception_request,params[:review][:assigned_to_id]).deliver_now
              ExceptionRequestMailer.form_status_notification_to_lxp(@exception_request).deliver_now  
            else
              @review.status = 'LAW_FIRM_EXIST'
              @review.save
              @exception_request.lxp_status = 'LAW_FIRM_EXIST'
              flash[:alert] = "Law Firm Already Exists"
            end  
            @exception_request.save 
          elsif current_user.role === 'lxp' &&  review_params[:status] == 'ASSIGN_LAW_FIRM'    
            @review.status = 'ASSIGN_LAW_FIRM'
            @review.save
            @exception_request.update_attributes(lxp_status: "APPROVED")
            @exception_request.update_attributes(law_firm_id: review_params[:law_firm_id])
            @exception_request.save
          elsif current_user.role === 'lxp' &&  review_params[:status] == 'ASSIGN_LAW_FIRM_ASSIGN_LAWYER'    
            @review.status = 'ASSIGN_LAW_FIRM_ASSIGN_LAWYER'
            @review.save
            ExceptionRequestMailer.form_status_notification_to_internal_lawyer(@exception_request,params[:review][:assigned_to_id]).deliver_now
            @exception_request.update_attributes(law_firm_id: review_params[:law_firm_id])
            @exception_request.save
          else
            if current_user.role === 'internal_lawyers'
              @exception_request.update_attributes(lxp_status: "REVIEWED_BY_LAWYER")
              ExceptionRequestMailer.form_status_notification_to_lxp(@exception_request).deliver_now
              ExceptionRequestMailer.form_status_notification_to_lob(@exception_request).deliver_now
            else
              ExceptionRequestMailer.form_status_notification_to_lob(@exception_request).deliver_now
            end
          end
        elsif params[:review][:reviewable_type] == "PanelRequest"
          @panel_request = PanelRequest.find_by_id(params[:review][:reviewable_id])
          @panel_request.lxp_status = review_params[:status]

          if current_user.role === 'lxp' && review_params[:status] == 'PANEL_RETAINER'
            @lob = User.find_by_id(@panel_request.user_id)
            lob_email = @lob.email
            lob_name =  @lob.username

            #user_id = @panel_request.law_firm.user.user_id
            #@user = User.with_deactivated.find_by(id: user_id)
            @user = @panel_request.try(:law_firm).try(:user)
            if @user.present?
              user_email = @user.email
              user_name =  @user.username
            else
              user_email = @panel_request.law_firm_mail
              user_name =  @panel_request.law_frim_name
            end
            @panel_request.send_retainer_for_esigning(lob_email, lob_name, user_email, user_name)
            if review_params[:status] == 'PANEL_RETAINER'
              @panel_request.status = 'PANEL_RETAINER'

              PanelRequestMailer.notification_for_retainer_to_law_firm(@panel_request).deliver_now
            else
              PanelRequestMailer.notification_for_retainer_to_lob(@panel_request).deliver_now
            end
            PanelRequestMailer.notification_for_retainer_to_user(@panel_request).deliver_now
          elsif current_user.role === 'lxp' &&  review_params[:status] == 'REJECTED'
            PanelRequestMailer.notification_for_rejected_to_user(@panel_request).deliver_now
          elsif current_user.role === 'lxp' &&  review_params[:status] == 'ARCHIVED'
            @panel_request.status = 'ARCHIVED'
            @panel_request.archived_at = Time.now 
            PanelRequestMailer.notification_for_status_to_user(@panel_request).deliver_now
          elsif current_user.role === 'lxp' &&  review_params[:status] == 'UN_ARCHIVED'
            @panel_request.status = 'UN_ARCHIVED'
            @panel_request.archived_at = nil 
            PanelRequestMailer.notification_for_status_to_user(@panel_request).deliver_now  
          elsif current_user.role === 'lxp' && review_params[:status] == 'LAW_FIRM_CREATED'
            
            @panel_request.archived_at = nil  
            @user = User.new 
            @user.email = @panel_request.law_firm_mail
            @user.role = 'master_user'
            @user.empty_user = true
            @user.tenant_id = Tenant.current&.id || current_user&.tenant&.id
            @user.status = nil
            if @user.save
              @law_firm = LawFirm.new
              @law_firm.user_id = @user.id
              @law_firm.law_firm_category = "PANEL"
              @law_firm.name = @panel_request.law_frim_name
              @law_firm.law_firm_category = @panel_request.law_firm_category
              @law_firm.contact_name = @panel_request.law_firm_contact_name
              @law_firm.firm_use_on_regular_basis = @panel_request.firm_use_on_regular_basis
              @law_firm.email = @panel_request.law_firm_mail
              @law_firm.phone = @panel_request.law_firm_phone
              @law_firm.save
              @panel_request.update_attributes(law_firm_id: @law_firm.id)
              @user.law_firm_id =  @law_firm.id
              @user.save
              @panel_request.status = 'LAW_FIRM_CREATED'
              begin
                LawFirmsTenant.create(
                  law_firm_id: @law_firm&.id,
                  tenant_id: @user.tenant_id
                )
              rescue => e
              end
              flash[:notice] = "Law Firm Created"
              PanelRequestMailer.notification_for_status_to_user(@panel_request).deliver_now  
            else
              @panel_request.status = 'LAW_FIRM_EXIST'
              @review.status = 'LAW_FIRM_EXIST'
              @review.save
              @panel_request.lxp_status = 'LAW_FIRM_EXIST'
              flash[:alert] = "Law Firm Already Exists"
            end
            
          elsif current_user.role === 'lxp' &&  review_params[:status] == 'APPROVED'
            @panel_request.status = 'Active'
            @panel_request.law_firm.status = 'Active'
            @user = @panel_request.law_firm.user
            @user.status = 'Active'
            @user.save
            #PanelRequestMailer.notification_for_approved_to_lob(@panel_request).deliver_now
            PanelRequestMailer.notification_for_status_to_user(@panel_request).deliver_now
          else
            PanelRequestMailer.notification_for_status_to_user(@panel_request).deliver_now
          end
          # @law_firm = @panel_request.law_firm
          # @law_firm.panel_status =  review_params[:status];
          # @law_firm.save
          @panel_request.save
        elsif params[:review][:reviewable_type] == "MatterIntake"  
          @matter_intake = MatterIntake.find_by(id: params[:review][:reviewable_id])
          if current_user.role === "lxp"
            if @matter_intake.update_attributes(lxp_reviewed_at: Time.now, status: 'awaiting_lawyer_update', lxp_id: current_user.id)
             #@matter_intake.add_log_for_lxp_rejects_and_returns_to_lawyer(current_user)
              @matter_intake.send_notification_to_lawyer_form_needs_updation
            end
          end
        else
          @conflict_waiver = ConflictWaiver.find_by_id(params[:review][:reviewable_id])
          if current_user.role === 'lxp' && ( review_params[:status] == 'ASSIGN_TO_LAWYER' && review_params[:assigned_to_id].present?)
            @conflict_waiver.update_attributes(assigned_to_id: review_params[:assigned_to_id])
            ConflictWaiverMailer.form_status_notification_to_internal_lawyer(@conflict_waiver,params[:review][:assigned_to_id]).deliver_now
            #ConflictWaiverMailer.form_status_approved_notification_to_law_firm_by_lxp(@conflict_waiver).deliver_now 
          elsif current_user.role === 'internal_lawyers' && review_params[:status] == 'APPROVED'
            @conflict_waiver.update_attributes(lxp_status: review_params[:status])
            ConflictWaiverMailer.form_status_notification_to_lxp_by_internal_lawyers(@conflict_waiver).deliver_now 
            ConflictWaiverMailer.form_status_notification_to_user(@conflict_waiver).deliver_now
          elsif current_user.role === 'internal_lawyers' && review_params[:status] == 'REQUEST_INFO'
            @conflict_waiver.update_attributes(lxp_status: review_params[:status])
            ConflictWaiverMailer.form_status_notification_to_lxp_for_info_internal_lawyers(@conflict_waiver).deliver_now 
          else
           if current_user.role === 'lxp' &&  review_params[:status] == 'ALREADY_COVERED'
            @conflict_waiver.update_attributes(retainer_cover: params[:review][:retainer_cover])
            ConflictWaiverMailer.form_status_notification_to_user(@conflict_waiver).deliver_now
           elsif current_user.role === 'lxp' && (review_params[:status] === 'APPROVED' ||  review_params[:status] === 'REQUEST_INFO' || review_params[:status] === 'IN_REVIEW_LXP' || review_params[:status] === 'REJECTED')
              ConflictWaiverMailer.form_status_notification_to_user(@conflict_waiver).deliver_now 
              @conflict_waiver.update_attributes(lxp_status: review_params[:status])
           elsif current_user.role === 'internal_lawyers' &&  review_params[:status] == 'REJECTED'
            @conflict_waiver.update_attributes(lxp_status: review_params[:status])
            ConflictWaiverMailer.form_status_notification_to_user(@conflict_waiver).deliver_now
            ConflictWaiverMailer.form_status_notification_to_lxp_by_internal_lawyers(@conflict_waiver).deliver_now 
           else
            ConflictWaiverMailer.form_status_notification_to_user(@conflict_waiver).deliver_now
           end
          end
        end

        if params[:review][:reviewable_type] == "ExceptionRequest" && current_user.role === 'internal_lawyers'
          @exception_request.update_attributes(lxp_status: "reviewed_by_lawyer")
          redirect_to admin_root_path
        elsif params[:review][:reviewable_type] == "ExceptionRequest" && current_user.role === 'lxp'
          redirect_to admin_root_path
        elsif params[:review][:reviewable_type] == "MatterIntake" && current_user.role === 'lxp'
          redirect_to admin_matter_intakes_path  
        elsif params[:review][:reviewable_type] == "PanelRequest" && current_user.role === 'lxp'
          redirect_to :back  
        else  
          redirect_to :back, notice: "Review Added"
        end


      else
        flash.now[:alert] = @review.errors.full_messages.join(', ')
        render :new
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:description, :status, :assigned_to_id, :pay_type, :reviewable_type, :reviewable_id, :retainer_cover, :law_firm_id)
  end

end
