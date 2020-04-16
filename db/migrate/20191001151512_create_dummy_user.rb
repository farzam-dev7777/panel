class CreateDummyUser < ActiveRecord::Migration[5.0]
  def up
    # lxp 
    lpx_user = User.new
    lpx_user.email = "demolxp@mailinator.com"
    lpx_user.username = "demo_lxp"
    lpx_user.first_name = "Demo"
    lpx_user.last_name = "Lxp"
    lpx_user.role = "lxp"
    lpx_user.password = "M3t@2012ware"
    lpx_user.password_confirmation = "M3t@2012ware"
    lpx_user.save


    # lob 
    lob_user = User.new
    lob_user.email = "demolob@mailinator.com"
    lob_user.username = "demo_lob"
    lob_user.role = "lob"
    lob_user.first_name = "Demo"
    lob_user.last_name = "Lob"
    lob_user.password = "M3t@2012ware"
    lob_user.password_confirmation = "M3t@2012ware"
    lob_user.save

    # lob 
    lawyer_user = User.new
    lawyer_user.email = "demolawyers@mailinator.com"
    lawyer_user.username = "demo_lawyers"
    lawyer_user.first_name = "Internal"
    lawyer_user.last_name = "Lawyer"
    lawyer_user.role = "internal_lawyers"
    lawyer_user.password = "M3t@2012ware"
    lawyer_user.password_confirmation = "M3t@2012ware"
    lawyer_user.save

  end
end
