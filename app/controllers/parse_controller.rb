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

    # render :nothing => true
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

      chat = ImChatParser.load(file.path)

      file.unlink
      
      chat
    end

    def save_into_db(chat)
      chat_record = ChatRecord.create
      chat.lines.each do |line|
        name_list = line.user.names.map {|item| item }.join(',')
        name_list = name_list.gsub(',', '').blank?? line.user.qq_num: name_list

        if User.where(:name_list => name_list).exists?
          user = User.where(:name_list => name_list).first
        else
          user = User.where(
            :name_list => name_list,
            :qq_num => line.user.qq_num
          ).first_or_create!
        end

        

        chat_record.lines.create(
          :user_id => user.id,
          :text => line.text,
          :time => line.time
        )
      end
    end

end