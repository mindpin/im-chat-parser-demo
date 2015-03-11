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
    chat = ImChatParser.load(file.path, params[:type])
    file.unlink

    # p chat.lines.length
    # p chat.users
    # p chat.lines[2].user
    # p chat.lines[2].text



    chat.lines.each do |line|
      user = User.where(
        :name_list => line.user.names.map {|item| item }.join(','),
        :qq_num => line.user.qq_num
      ).first_or_create!

      Line.create(
        :user_id => user.id,
        :text => line.text
      )
    end

    # redirect_to '/'
    render :nothing => true
  end

end