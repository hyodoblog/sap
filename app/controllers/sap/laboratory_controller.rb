class Sap::LaboratoryController < Sap::ApplicationController
  before_action :check_laboratory

  def index
    @laboratory = Laboratory.find(session[:laboratory_id])
    @choice_students = LaboratoryChoice.where(laboratory_id: session[:laboratory_id])
    choice_students_id_array = @choice_students.map{|choice| choice.student.id}
    @students = Student.where(user_id: @admin.id).where.not(id: choice_students_id_array)

    @laboratory_assign_confirm = false
    begin
      assigns = AssignList.where(laboratory_id: session[:laboratory_id])
      assigns.each do |assign|
        if assign.confirm
          @laboratory_assign_confirm = true
          break
        end
      end
    rescue
      @laboratory_assign_confirm = false
    end
  end

  def choice
    begin
      choice_students_data = choice_student_params[:items] 
    rescue
      flash[:alert] = '提出した希望リストに不具合があります'
      flash[:error_messages] = ['希望の研究室が1人も選択されていません。', '最低でも1人は希望してください！']
      redirect_back(fallback_location: root_path) and return
    end

    # 過去の提出データをすべて削除
    choice_students = LaboratoryChoice.where(laboratory_id: session[:laboratory_id])
    choice_students.each do |choice_student|
      choice_student.destroy
    end

    choice_students_data.each_with_index do |item, index|
      rank = index + 1
      if rank > @admin.max_choice_student.to_i
        break
      end

      choice_student_data = LaboratoryChoice.new(student_id: item[:student_id], laboratory_id: session[:laboratory_id], rank: rank)
      unless choice_student_data.save
        flash[:alert] = '提出した希望リストに不具合があります'
        flash[:error_messages] = choice_student_data.errors.full_messages
        redirect_back(fallback_location: root_path) and return
      end
    end

    flash[:notice] = '提出が完了しました'
    redirect_to(sap_laboratory_path+'?sap_key='+session[:sap_key])
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
