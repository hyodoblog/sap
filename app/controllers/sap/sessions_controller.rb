class Sap::SessionsController < Sap::ApplicationController
  skip_before_action :check_sap_key, :check_view_end_datetime

  def new
  end

  def create
    # 研究室
    laboratory = Laboratory.find_by(loginid: params[:sap_session][:loginid])
    if laboratory && laboratory.authenticate(params[:sap_session][:password])
      session[:laboratory_id] = laboratory.id
      session[:sap_key] = params[:sap_key]
      flash[:notice] = 'ログインしました'
      redirect_to(sap_laboratory_path + "?sap_key=" + session[:sap_key]) and return
    end

    # 学生
    student = Student.find_by(loginid: params[:sap_session][:loginid])
    if student && student.authenticate(params[:sap_session][:password])
      session[:student_id] = student.id
      session[:sap_key] = params[:sap_key]
      flash[:notice] = 'ログインしました'
      redirect_to(sap_student_path + "?sap_key=" + session[:sap_key]) and return
    end

    flash[:alert] = 'ログインIDまたはパスワードが違います'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    session.delete(:laboratory_id)
    session.delete(:student_id)
    session.delete(:sap_key)
    redirect_to(sap_signin_path+"?sap_key="+params[:sap_key])
  end
end
