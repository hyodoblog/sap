class Admin::LaboratoryController < Admin::ApplicationController
  before_action :set_laboratory, only: %i[edit update destroy]

  def new
    @laboratory = Laboratory.new(flash[:laboratory])
  end

  def create
    laboratory = Laboratory.new(laboratory_params)
    if laboratory.save(context: :registration)
      flash[:notice] = laboratory.laboratory_name+'を追加しました'
      redirect_to admin_root_path
    else
      flash[:laboratory] = laboratory
      flash[:error_messages] = laboratory.errors.full_messages
      redirect_back fallback_location: root_path
    end
  end

  def edit
  end

  def update
    if @laboratory.update(laboratory_params)
      redirect_to admin_root_path
    else
      flash[:error_messages] = @laboratory.errors.full_messages
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @laboratory.destroy
    flash[:notice] = "「#{@laboratory.laboratory_name}」を削除しました"
    redirect_to admin_root_path
  end

  private

  def laboratory_params
    params.require(:laboratory).permit(:loginid, :password, :password_confirmation,
                                       :name, :laboratory_name, :max_num, :user_id)
  end

  def set_laboratory
    @laboratory = Laboratory.find(params[:id])
  end
end
