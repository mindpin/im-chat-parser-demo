class HomeController < ApplicationController

  def index
    @chat_records = ChatRecord.page params[:page]
  end

  def show
    @chat_record = ChatRecord.find(params[:id])
    @lines = @chat_record.lines
  end

  def test_taobao_api_callback

    render :nothing => true
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