class Admin::StudentController < Admin::ApplicationController
  before_action :set_student, only: %i[edit update destroy]

  def new
    @student = Student.new(flash[:student])
  end

  def create
    student = Student.new(student_params)
    if student.save(context: :registration)
      flash[:notice] = student.name+'を追加しました'
      redirect_to admin_mypage_path
    else
      flash[:student] = student
      flash[:error_messages] = student.errors.full_messages
      redirect_back fallback_location: root_path
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      redirect_to admin_mypage_path
    else
      flash[:error_messages] = @student.errors.full_messages
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @student.destroy
    flash[:notice] = "「#{@student.name}」を削除しました"
    redirect_to admin_mypage_path
  end

  private

  def student_params
    params.require(:student).permit(:loginid, :password, :password_confirmation,
                                       :name, :student_num, :user_id)
  end

  def set_student
    @student = Student.find(params[:id])
  end
end
