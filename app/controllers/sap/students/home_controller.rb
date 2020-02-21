class Sap::Students::HomeController < Sap::ApplicationController
  before_action :student_check!
  before_action :authenticate_student!
  
  def index
    @choice_laboratories = current_student.student_choice
    choice_laboratories_id_array = @choice_laboratories.map{|choice| choice.laboratory.id}
    @laboratories = @admin.laboratory.where.not(id: choice_laboratories_id_array)
  end

  def choice
    # エラーチェック
    begin
      choice_laboratories_data = choice_labratory_params[:items] 
    rescue
      flash[:alert] = '提出した希望リストに不具合があります'
      flash[:error_messages] = ['希望の研究室が1つも選択されていません。', '最低でも1つは希望してください！']
      redirect_back(fallback_location: root_path) and return
    end

    # 過去の提出データをすべて削除
    choice_laboratories = current_student.student_choice.destroy_all

    choice_laboratories_data.each_with_index do |item, index|
      rank = index + 1
      if rank > @admin.max_choice_laboratory.to_i
        break
      end

      choice_laboratory_data = current_student.student_choice.new(admin_id: current_student.admin.id, laboratory_id: item[:laboratory_id], rank: rank)
      unless choice_laboratory_data.save()
        flash[:alert] = '提出した希望リストに不具合があります'
        flash[:error_messages] = choice_laboratory_data.errors.full_messages
        redirect_back(fallback_location: root_path) and return
      end
    end

    flash[:notice] = '提出が完了しました'
    redirect_to(students_root_path(@sap_key))
  end

  private

  def choice_labratory_params
    params.require(:choice_laboratory).permit(items: [:laboratory_id])
  end

  def check_student
    unless session[:student_id]
      redirect_to(root_path)
    end
  end
end
