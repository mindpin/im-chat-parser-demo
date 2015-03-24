class HomeController < ApplicationController

  def index
    @chat_records = ChatRecord.page params[:page]
  end

  def show
    @chat_record = ChatRecord.find(params[:id])
    @lines = @chat_record.lines
  end


  def user_chat
    user = User.find(params[:user_id])
    @lines = user.lines.page params[:page]
  end

end