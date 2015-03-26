require 'im-chat-parser'


file = '/Users/xiaorich/www/mindpin/im-chat-parser-demo/scripts/test.text'
chat = ImChatParser.load(file)


p chat.users
p chat.lines
p '======='
p chat.lines[1].user
p chat.lines[1].user.qq_num
p chat.lines[1].time
p chat.lines[1].text


p '======='
p chat.lines.last.text