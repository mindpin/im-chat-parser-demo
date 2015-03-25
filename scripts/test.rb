require 'im-chat-parser'


file = '/Users/xiaorich/www/mindpin/im-chat-parser-demo/scripts/test.text'
chat = ImChatParser.load(file, 'single')


p chat.users
p chat.lines
p chat.lines[1].user
p chat.lines[1].user.qq_num