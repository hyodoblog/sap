class Admins::InitController < Admins::ApplicationController
  def all
    laboratories_destroy
    students_destroy
    flash[:notice] = '全学生・研究室を削除しました'
    redirect_to(admins_root_path)
  end

  def laboratory
    laboratories_destroy
    flash[:notice] = '全研究室を削除しました'
    redirect_to(admins_root_path)
  end

  def student
    students_destroy
    flash[:notice] = '全学生を削除しました'
    redirect_to(admins_root_path)
  end

  private

  def laboratories_destroy
    current_admin.laboratory.each do |laboratory|
      laboratory.destroy
    end
  end

  def students_destroy
    current_admin.student.each do |student|
      student.destroy
    end
  end
end
