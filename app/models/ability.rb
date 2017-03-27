class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    if user.class.to_s == 'AdminUser'
      can :manage, :all
    else
      can :manage, FormSubmission do |fs|
        user.law_firm.form_submissions.latest.id == fs.id
      end
      can :manage, FileAttachment do |fa|
        fa.form_value.submittable.law_firm_id == user.law_firm.id
      end
      can :read, :SecurityThreat
      can :read, :SecurityAlert
    end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
