class Admins::StudentsController < Admins::ApplicationController
  before_action :set_student, only: %i[edit update destroy]

  def new
    @student = current_admin.student.new(flash[:student])
  end

  def create
    student = current_admin.student.new(student_params_create)
    if student.save(context: :registration)
      flash[:notice] = student.name+'を追加しました'
      redirect_to(admins_root_path)
    else
      flash[:student] = student
      flash[:error_messages] = student.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
  end

  def update
    if @student.update(student_params_update)
      flash[:notice] = "#{@student.name}を編集しました"
      redirect_to(admins_root_path)
    else
      flash[:error_messages] = @student.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @student.destroy
    flash[:notice] = "「#{@student.name}」を削除しました"
    redirect_to(admins_root_path)
  end

  private

  def student_params_create
    params[:student][:password_init] = params[:student][:password]
    params.require(:student).permit(:email, :password, :password_confirmation,
                                    :password_init, :name, :student_num)
  end

  def student_params_update
    params.require(:student).permit(:name, :student_num)
  end

  def set_student
    @student = current_admin.student.find(params[:id])
    if @student.nil?
      flash[:alert] = '学生情報の取得に失敗しました'
      redirect_to(admins_root_path) 
    end
  end
end
