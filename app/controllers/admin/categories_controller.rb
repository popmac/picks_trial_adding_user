class Admin::CategoriesController < Admin::Base
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(create_category_params)
    @category.sort_order = @category.last_sort_order
    if @category.save
      flash.notice = 'カテゴリを登録しました'
      redirect_to :admin_categories
    else
      flash.now[:alert] = 'カテゴリの登録に失敗しました'
      render action: 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.assign_attributes(update_category_params)
    if @category.save
      flash.notice = 'カテゴリを更新しました'
      redirect_to :admin_categories
    else
      flash.now[:alert] = 'カテゴリの更新に失敗しました'
      render action: 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash.notice = 'カテゴリを削除しました'
    else
      flash.alert = 'カテゴリの削除に失敗しました'
    end
    redirect_to :admin_categories
  end

  private
  def create_category_params
    params.require(:category).permit(:name)
  end

  def update_category_params
    params.require(:category).permit(:name, :sort_order)
  end
end
