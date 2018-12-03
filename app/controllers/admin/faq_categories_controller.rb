class Admin::FaqCategoriesController < Admin::BaseController

  layout 'admin'
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @q = FaqCategory.ransack(params[:q])
    @faq_categories = @q.result(distinct: true).paginate(page: params[:page])
  end

  def create
    @faq_category = FaqCategory.new(faq_params)
    if @faq_category.save
      redirect_to admin_faq_categories_path, notice: "Created successfully."
    else
      flash.now[:alert] = @faq_category.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    @faq_category = FaqCategory.find(params[:id])
    if @faq_category.update(faq_params)
      redirect_to admin_faq_categories_path, notice: "Updated successfully."
    else
      flash.now[:alert] = @faq_category.errors.full_messages.join(', ')
      render :edit
    end
  end

  def new
    @faq_category = FaqCategory.new
  end

  def edit
    @faq_category = FaqCategory.find(params[:id])
  end

  def show
    @faq_category =  FaqCategory.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @faq_category = FaqCategory.find(params[:id])
    if @faq_category.destroy
      alert_msg = "FAQ categoy has been successfully deleted"
      redirect_to admin_faq_categories_path, notice: alert_msg
    else
      redirect_to admin_faq_categories_path, alert: "Couldn't delete the FAQ"
    end
  end

  private

  def faq_params
    params.require(:faq_category).permit(:name)
  end

end
