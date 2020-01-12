class Sap::AssignListController < Sap::ApplicationController
  skip_before_action :check_sap_key, if: -> { user_signed_in? }

  def index
    laboratories = Laboratory.where(user_id: @config.user_id)

    # 更新時間の表示
    begin
      @last_update_time = AssignList.find_by(laboratory_id: laboratories[0].id).updated_at
    rescue => exception
      @last_update_time = nil
    end

    # データ整形
    # 表示しやすい形式に変換
    @assign_list = {}
    laboratories.each do |laboratory|
      assigns = AssignList.where(laboratory_id: laboratory.id)
      assign_array = []
      assigns.each do |assign|
        assign_student_array = []
        assign_student_array.push(assign.student.student_num)
        assign_student_array.push(assign.confirm)
        assign_array.push(assign_student_array)
      end
      @assign_list[laboratory.name] = assign_array
    end

    if session[:student_id]
      assign = AssignList.find_by(student_id: session[:student_id])
      @student_assign_confirm = assign.confirm
      @student_assign_laboratory_name = assign.laboratory.laboratory_name
    end
  end
end
