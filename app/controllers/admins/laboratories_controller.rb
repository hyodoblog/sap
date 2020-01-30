class Admins::LaboratoriesController < Admins::ApplicationController
  before_action :set_laboratory, only: %i[edit update destroy]

  def new
    @laboratory = current_admin.laboratory.new(flash[:laboratory])
  end

  def create
    laboratory = current_admin.laboratory.new(laboratory_params)
    if laboratory.save(context: :registration)
      flash[:notice] = laboratory.name+'を追加しました'
      redirect_to(admins_root_path)
    else
      flash[:laboratory] = laboratory
      flash[:error_messages] = laboratory.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
  end

  def update
    if @laboratory.update(laboratory_params)
      redirect_to(admins_root_path)
    else
      flash[:error_messages] = @laboratory.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @laboratory.destroy
    flash[:notice] = "「#{@laboratory.name}」を削除しました"
    redirect_to(admins_root_path)
  end

  private

  def laboratory_params
    params.require(:laboratory).permit(:email, :password, :password_confirmation,
                                       :name, :professor_name, :max_num, :admin_id)
  end

  def set_laboratory
    @laboratory = current_admin.laboratory.find(params[:id])
  end
end
