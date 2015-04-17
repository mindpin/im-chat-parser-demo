class HomeController < ApplicationController

  def index
    @chat_records = ChatRecord.page params[:page]

    # jd test code
    jd = Jd.new
    @jd_oauth_link = jd.build_url

    if params && params['code']
      data = jd.get_access_token(params['code'])

      JdUser.create(:token => data['access_token'])
    end
    
  end

  def show
    @chat_record = ChatRecord.find(params[:id])
    @lines = @chat_record.lines
  end


  def user_chat
    user = User.find(params[:user_id])
    @lines = user.lines.page params[:page]
  end

  def destroy
    chat_record = ChatRecord.find(params[:id])
    chat_record.lines.each do |line|
      line.user.destroy if line.user
      line.destroy
    end

    chat_record.destroy

    redirect_to '/' 
  end

end