class Admin::InitController < Admin::ApplicationController
  def all
    laboratories_destroy
    students_destroy
    flash[:notice] = '全学生・研究室を削除しました'
    redirect_to admin_root_path
  end

  def laboratory
    laboratories_destroy
    flash[:notice] = '全研究室を削除しました'
    redirect_to admin_root_path
  end

  def student
    students_destroy
    flash[:notice] = '全学生を削除しました'
    redirect_to admin_root_path
  end

  private

  def laboratories_destroy
    laboratories = Laboratory.where(user_id: current_user.id)
    laboratories.each do |laboratory|
      laboratory.destroy
    end
  end

  def students_destroy
    students = Student.where(user_id: current_user.id)
    students.each do |student|
      student.destroy
    end
  end
end
