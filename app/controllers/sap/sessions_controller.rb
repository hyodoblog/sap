class Sap::SessionsController < Sap::ApplicationController
  skip_before_action :check_view_end_datetime

  def new
  end

  def create
    if user_signed_in?
      flash[:alert] = '管理者アカウントを一度ログアウトしてください！'
      redirect_back(fallback_location: root_path) and return
    end
    admin_id = Config.find_by(sap_key: params[:sap_key]).user_id
    # 研究室
    laboratory = Laboratory.where(user_id: admin_id).where(email: login_params[:email])
    laboratory = laboratory[0]
    if laboratory && laboratory.authenticate(login_params[:password])
      session[:laboratory_id] = laboratory.id
      session[:sap_key] = params[:sap_key]
      flash[:notice] = 'ログインしました'
      redirect_to(sap_laboratory_path + "?sap_key=" + session[:sap_key]) and return
    end

    # 学生
    student = Student.where(user_id: admin_id).where(email: login_params[:email])
    student = student[0]
    if student && student.authenticate(login_params[:password])
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

  private

  def login_params
    params.require(:sap_session).permit(:email, :password)
  end
end
