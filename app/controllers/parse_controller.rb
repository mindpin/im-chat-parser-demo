require 'im-chat-parser'

class ParseController < ApplicationController

  def index
    

    # render :nothing => true
  end


  def create
    file = Tempfile.new('foo')
    # p file.path
    file.write(params[:chat_text])
    file.rewind
    # file.read
    file.close

    # p file.path
    # p '===='
    
    first_line = File.open(file.path) {|f| f.readline}
    if (first_line =~ /^【/)
      chat = ImChatParser.load(file.path, 'multiple')
    else
      chat = ImChatParser.load(file.path, 'single')
    end

    file.unlink

    # p chat.lines.length
    # p chat.users
    # p chat.lines[2].user
    # p chat.lines[2].text

    chat_record = ChatRecord.create

    chat.lines.each do |line|
      user = User.where(
        :name_list => line.user.names.map {|item| item }.join(','),
        :qq_num => line.user.qq_num
      ).first_or_create!

      chat_record.lines.create(
        :user_id => user.id,
        :text => line.text,
        :time => line.time
      )
    end

    redirect_to '/'
    # render :nothing => true
  end

end