require 'im-chat-parser'

class ParseController < ApplicationController

  def index
    

    # render :nothing => true
  end


  def create
    begin
      tmp_file = build_tmp_file
      chat = parse_chat_file(tmp_file)

      save_into_db(chat)

      redirect_to '/'
    rescue Exception => e
      p e.message
      render :nothing => true
    end
  end


  private
    def build_tmp_file
      file = Tempfile.new('foo')
      # p file.path
      file.write(params[:chat_text])
      file.rewind
      # file.read
      file.close

      # p file.path
      # p '===='
      file
    end

    def parse_chat_file(file)
      file = build_tmp_file

      first_line = File.open(file.path) {|f| f.readline}
      if (first_line =~ /^【/)
        chat = ImChatParser.load(file.path, 'multiple')
      else
        chat = ImChatParser.load(file.path, 'single')
      end

      file.unlink
      
      chat
    end

    def save_into_db(chat)
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
    end

end