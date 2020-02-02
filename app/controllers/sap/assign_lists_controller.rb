class Sap::AssignListsController < Sap::ApplicationController
  before_action :admin_set

  def index
    laboratories = @admin.laboratory.order(id: 'ASC')

    # 更新時間の表示
    begin
      @last_update_time = @admin.assign_list.first().updated_at
    rescue
      @last_update_time = nil
    end

    # データ整形
    # 表示しやすい形式に変換
    @assign_list = {}
    laboratories.each do |laboratory|
      assigns = @admin.assign_list.where(laboratory_id: laboratory.id).order(id: 'DESC')
      assign_array = []
      assigns.each do |assign|
        assign_student_array = []
        assign_student_array.push(assign.student.student_num)
        assign_student_array.push(assign.confirm)
        assign_array.push(assign_student_array)
      end
      @assign_list[laboratory.name] = assign_array
    end
    
    if current_student
      assign = @admin.assign_list.find_by(student_id: current_student.id)
      if assign.present?
        @student_assign_confirm = assign.confirm
        @student_assign_laboratory_name = assign.laboratory.name
      else
        @student_assign_confirm = nil
      end
    else
      @student_assign_confirm = nil
    end
  end

  private

  def admin_set
    if current_admin.present?
      @admin = current_admin
    elsif current_student.present?
      @admin = current_student.admin
    elsif current_laboratory.present?
      @admin = current_laboratory.admin
    end
  end
end
