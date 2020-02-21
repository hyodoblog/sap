class Admins::NoticesController < Admins::ApplicationController
  skip_before_action :release_true_check!

  def index
  end

  def create
    notice = Notice.new(notice_param)
    if notice.save()
      flash[:notice] = 'お知らせを追加しました'
      redirect_to(admins_notices_path)
    else
      flash[:notice_param] = notice
      flash[:error_messages] = notice.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    notice = current_admin.notice.find(params[:id])
    if notice.nil?
      flash[:alert] = 'お知らせ情報の取得に失敗しました'
      redirect_back(fallback_location: root_path)
    else
      notice.destroy
      flash[:notice] = 'お知らせを1つ削除しました'
      redirect_to(admins_notices_path)
    end
  end

  private

  def notice_param
    params.require(:notice).permit(:content, :admin_id)
  end
end
