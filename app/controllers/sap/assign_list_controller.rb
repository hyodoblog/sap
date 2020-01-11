class Sap::AssignListController < Sap::ApplicationController
  skip_before_action :check_sap_key, if: -> { user_signed_in? }
  skip_before_action :check_view_end_datetime

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
        assign_array.push(assign.student.student_num)
      end
      @assign_list[laboratory.name] = assign_array
    end
  end
end
