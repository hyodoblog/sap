class Sap::Laboratories::HomeController < Sap::ApplicationController
  before_action :laboratory_check!
  before_action :authenticate_laboratory!
  include Algorithm

  def index
    @choice_students = current_laboratory.laboratory_choice
    choice_students_id_array = @choice_students.map{|choice| choice.student.id}
    @students = @admin.student.where.not(id: choice_students_id_array).order(student_num: 'ASC')
  end

  def choice
    # エラーチェック
    begin
      choice_students_data = choice_student_params[:items] 
    rescue
      flash[:alert] = '提出した希望リストに不具合があります'
      flash[:error_messages] = ['希望の研究室が1人も選択されていません。', '最低でも1人は希望してください！']
      redirect_back(fallback_location: root_path) and return
    end

    # 過去の提出データをすべて削除
    choice_students = current_laboratory.laboratory_choice.destroy_all

    choice_students_data.each_with_index do |item, index|
      rank = index + 1
      if rank > @admin.max_choice_student.to_i
        break
      end

      choice_student_data = current_laboratory.laboratory_choice.new(admin_id: current_laboratory.admin.id, student_id: item[:student_id], rank: rank)
      unless choice_student_data.save()
        flash[:alert] = '提出した希望リストに不具合があります'
        flash[:error_messages] = choice_student_data.errors.full_messages
        redirect_back(fallback_location: root_path) and return
      end
    end

    # アルゴリズムの実行
    algo_update(current_laboratory.admin)

    flash[:notice] = '希望を提出し、アルゴリズムの実行が完了しました'
    redirect_to(assign_lists_path(@sap_key))
  end

  private

  def choice_student_params
    params.require(:choice_student).permit(items: [:student_id])
  end

  def check_laboratory
    unless session[:laboratory_id]
      redirect_to sap_signin_path
    end
  end
end
