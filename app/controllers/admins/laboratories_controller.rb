class Admins::LaboratoriesController < Admins::ApplicationController
  before_action :set_laboratory, only: %i[edit update destroy]

  def new
    @laboratory = current_admin.laboratory.new(flash[:laboratory])
  end

  def create
    laboratory = current_admin.laboratory.new(laboratory_params_create)
    if laboratory.save(context: :create)
      flash[:notice] = "「#{laboratory.name}」を追加しました"
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
    @laboratory.attributes = laboratory_params_update
    if @laboratory.save()
      flash[:notice] = "「#{@laboratory.name}」を編集しました"
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

  def laboratory_params_create
    params[:laboratory][:password_init] = params[:laboratory][:password]
    params.require(:laboratory).permit(:email, :password, :password_confirmation,
                                       :password_init, :name, :professor_name, :max_num)
  end

  def laboratory_params_update
    params.require(:laboratory).permit(:name, :professor_name, :max_num)
  end

  def set_laboratory
    @laboratory = current_admin.laboratory.find(params[:id])
    if @laboratory.nil?
      flash[:alert] = '研究室情報の取得に失敗しました'
      redirect_to(admins_root_path)
    end
  end
end
